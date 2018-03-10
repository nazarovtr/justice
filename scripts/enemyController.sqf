waitUntil {
    sleep 1;
    !isNil("JTC_enemyBases");
};
JTC_goal_parked = "parked";
JTC_goal_guard = "guard";
JTC_goal_rtb = "rtb";
JTC_goal_support = "support";
// [baseNumber, group, vehicle, parking, goal, target]
JTC_spawnedEnemies = [];
JTC_alarmedBases = [];
JTC_spawnedBases = [];
JTC_supportedBases = [];

private _spawnBases = {
    for "_baseNumber" from 0 to (count JTC_enemyBases) - 1 do {
        if ((JTC_spawnedBases find _baseNumber) < 0) then {
            private _base = JTC_enemyBases select _baseNumber;
            if ([getMarkerPos (_base select 0)] call JTC_fnc_isInSpawnArea) then {
                [_baseNumber] call JTC_fnc_populateBase;
                JTC_spawnedBases pushBackUnique _baseNumber;
            };
        };
    };
};

private _spawnSupport = {
    {
        private _alarmedBaseNumber = _x;
        private _attackHelicopterParkings = [];
        private _attackHelicopterData = [];
        for "_baseNumber" from 0 to (count JTC_enemyBases) - 1 do {
            private _base = JTC_enemyBases select _baseNumber;
            if ((_base select 3 == "ok")) then {
                {
                    if ((_x select 0) isKindOf "Air" && (_x select 4)) then {
                        _attackHelicopterParkings pushBack (_x select 5);
                        private _vehicleData = +_x;
                        _vehicleData pushBack _baseNumber;
                        _attackHelicopterData pushBack _vehicleData;
                    };
                } forEach (_base select 4);
            };
        };
        private _spawned = [];
        {
            private _group = _x select 1;
            private _parking = _x select 3;
            private _goal = _x select 4;
            private _index = _attackHelicopterParkings find _parking;
            if ((_index >= 0) && !isNull _group && (_goal == JTC_goal_guard || _goal == JTC_goal_rtb)) then {
                _spawned pushBack _x;
            };
            _attackHelicopterData deleteAt _index;
            _attackHelicopterParkings deleteAt _index;
        } forEach JTC_spawnedEnemies;
        while {("counterattacks" call JTC_fnc_isEscalated) && ((count _spawned) < 2)
                && ((count _attackHelicopterParkings) > 0)} do {
            private _closestParkingNumber = 0;
            private _minimumParkingDistance = 100000;
            for "_parkingNumber" from 0 to (count _attackHelicopterParkings) - 1 do {
                private _vehicleData = _attackHelicopterData select _parkingNumber;
                private _distance = (getMarkerPos (_vehicleData select 5)) distance2D
                    (getMarkerPos ((JTC_enemyBases select _alarmedBaseNumber) select 0));
                if (_distance < _minimumParkingDistance) then {
                    _closestParkingNumber = _parkingNumber;
                    _minimumParkingDistance = _distance;
                };
            };
            private _vehicleData = _attackHelicopterData select _closestParkingNumber;
            private _parkingMarker = _vehicleData select 5;
            private _vehiclePosition = markerPos _parkingMarker;
            private _vehicleDirection = markerDir _parkingMarker;
            private _vehicle = (_vehicleData select 0) createVehicle (getMarkerPos "safe_spawn");
            _vehicle setDir _vehicleDirection;
            _vehicle setPos _vehiclePosition;
            createVehicleCrew _vehicle;
            private _group = group ((crew _vehicle) select 0);
            _group addVehicle _vehicle;
            private _spawnedEntity = [_vehicleData select 6, _group, _vehicle, _parkingMarker, JTC_goal_support, _alarmedBaseNumber];
            JTC_spawnedEnemies pushBack _spawnedEntity;
            _spawned pushBack _spawnedEntity;
            _group call JTC_fnc_addEnemyDeathHandler;
            _vehicle call JTC_fnc_addEnemyVehicleDescructionHandler;
            _attackHelicopterData deleteAt _closestParkingNumber;
            _attackHelicopterParkings deleteAt _closestParkingNumber;
        };
        _spawned call JTC_fnc_addBaseNumberFields;
        {
            _x set [4, JTC_goal_support];
            _x set [5, _alarmedBaseNumber];
        } forEach _spawned;
        JTC_supportedBases pushBackUnique _x;
    } forEach (JTC_alarmedBases select {(JTC_supportedBases find _x) < 0;});
};
private _debugMarkers = [];
while {true} do {
    call _spawnBases;
    call _spawnSupport;
    for "_enemyNumber" from (count JTC_spawnedEnemies) - 1 to 0 step -1 do {
        private _enemyEntity = JTC_spawnedEnemies select _enemyNumber;
        private _baseNumber = _enemyEntity select 0;
        private _base = JTC_enemyBases select _baseNumber;
        private _baseMarker = _base select 0;
        private _group = _enemyEntity select 1;
        private _vehicle = _enemyEntity select 2;
        private _entityActive = false;
        if (!isNull _vehicle) then {
            if (alive _vehicle) then {
                _entityActive = true;
            } else {
                _enemyEntity set [2, objNull];
                _vehicle = objNull;
            };
        };
        if (!isNull _group) then {
            private _groupAlive = false;
            {
                if (alive _x) then {
                    _groupAlive = true;
                };
            } forEach units _group;
            if (!_groupAlive) then {
                _enemyEntity set [1, grpNull];
                _group = grpNull;
            };
            _entityActive = _entityActive || _groupAlive;
        };
        if (_entityActive) then {
            private _groupIsInVehicle = _vehicle == vehicle leader _group;
            private _parkingMarker = _enemyEntity select 3;
            private _goal = _enemyEntity select 4;
            private _target = _enemyEntity select 5;
            private _position = if (!isNull _group) then {
                position leader _group;
            } else {
                position _vehicle;
            };
            //support waypoints
            if (_goal == JTC_goal_support && !(isNull _group)) then {
                if (_groupIsInVehicle && (JTC_alarmedBases find _target) >= 0) then {
                    if ((count waypoints _group) <= currentWaypoint _group) then {
                        private _waypoint = _group addWaypoint [getMarkerPos ((JTC_enemyBases select _target) select 0), 500];
                        _waypoint setWaypointType "SAD";
                        _group setCombatMode "RED";
                        ["SAD waypoint created"] call JTC_fnc_log;
                    };
                    {
                       private _enemyKnowsAboutPlayer = _x call JTC_fnc_enemyKnowsAboutObject;
                       if (_enemyKnowsAboutPlayer select 0 > 0.05 and _enemyKnowsAboutPlayer select 1  < 20) then {
                            _group reveal _x;
                       };
                    } forEach allPlayers;
                } else {
                    _enemyEntity set [4, JTC_goal_rtb];
                    _enemyEntity set [5, _baseNumber];
                    _goal = JTC_goal_rtb;
                    _target = _baseNumber;
                    private _waypoint = _group addWaypoint [getMarkerPos _parkingMarker, 0];
                    _waypoint setWaypointType "MOVE";
                    _group setCurrentWaypoint _waypoint;
                    _group setCombatMode "YELLOW";
                };
            };
            if (_groupIsInVehicle && _vehicle isKindOf "Helicopter" && _goal == JTC_goal_rtb
                    && (count waypoints _group) <= currentWaypoint _group
                    && ((getMarkerPos _parkingMarker) distance2D (position _vehicle)) < 200) then {
                _vehicle land "LAND";
            };
            //steal
            if (!isNull _vehicle) then {
                private _stolen = _vehicle getVariable "_stolen";
                if (isNil "_stolen" &&
                        (((position _vehicle) distance2D getMarkerPos _baseMarker) > 300) &&
                        (alive _vehicle)) then {
                    private _crew = crew _vehicle;
                    private _enemyCrew = false;
                    {
                        if ((alive _x) && (faction _x) == JTC_enemyFaction) then {
                            _enemyCrew = true;
                        };
                    } forEach _crew;
                    if (!_enemyCrew) then {
                        _vehicle setVariable ["_stolen", true, true]; // do not despawn
                        ["Enemy vehicle stolen"] call JTC_fnc_log;
                        [_vehicle, _base] call JTC_fnc_removeVehicleFromEnemyBase;
                    };
                };
            };
            if (JTC_log) then {
                if (_goal == JTC_goal_rtb || _goal == JTC_goal_support) then {
                    private _markerName = format ["%1 %2", _goal, _group];
                    createMarker [_markerName, _position];
                    _markerName setMarkerText _markerName;
                    _markerName setMarkerShape "ICON";
                    _markerName setMarkerType "hd_dot";
                    _markerName setMarkerColor "ColorRed";
                    _debugMarkers pushBack _markerName;
                };
            };
            //despawn
            if ((_goal == JTC_goal_guard || _goal == JTC_goal_parked || _goal == JTC_goal_rtb)
                    && !([_position, JTC_spawnDistance + 200] call JTC_fnc_isInSpawnArea)
                    && !([getMarkerPos _baseMarker] call JTC_fnc_isInSpawnArea)) then {
                JTC_spawnedBases deleteAt (JTC_spawnedBases find _baseNumber);
                JTC_alarmedBases deleteAt (JTC_alarmedBases find _baseNumber);
                JTC_supportedBases deleteAt (JTC_supportedBases find _baseNumber);
                if (!isNull _group) then {
                    {
                        deleteVehicle _x;
                    } forEach units _group;
                    deleteGroup _group;
                };
                if (!isNull _vehicle) then {
                    private _stolen = _vehicle getVariable "_stolen";
                    if (isNil "_stolen") then {
                        deleteVehicle _vehicle;
                    };
                };
                JTC_spawnedEnemies deleteAt _enemyNumber;
            };
        } else {
            JTC_spawnedEnemies deleteAt _enemyNumber;
        };
    };
    sleep 5;
    if (JTC_log) then {
        {
            deleteMarker _x;
        } forEach _debugMarkers;
        _debugMarkers = [];
    };
};