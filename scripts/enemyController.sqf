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
JTC_abandonInProgressBases = [];

private _getEntityName = {
     if (!isNull (_this select 2)) then { typeOf (_this select 2); } else { _this select 1; };
};

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

private _abandonBases = {
    {
        private _baseNumber = _x;
        private _base = JTC_enemyBases select _baseNumber;
        private _usableEmptyVehicles = [];
        private _groupsWithoutVehicles = [];
        private _groupsWithVehicles = [];
        {
            if ((_x select 0) == _baseNumber) then {
                if (isNull (_x select 1)) then {
                    _usableEmptyVehicles pushBack _x;
                } else {
                    if (isNull (_x select 2)) then {
                        _groupsWithoutVehicles pushBack _x;
                    } else {
                        _groupsWithVehicles pushBack _x;
                    }
                }
            };
        } forEach JTC_spawnedEnemies;
        {
            private _group = _x select 1;
            {
                _group addVehicle (_x select 2);
            } forEach _usableEmptyVehicles;
        } forEach _groupsWithoutVehicles;
        private _evacuationBaseNumber = _base call JTC_fnc_selectEvacuationBase;
        private _evacuationBase = JTC_enemyBases select _evacuationBaseNumber;
        _evacuationBase set [1, (_evacuationBase select 1) + (_base select 1)];
        _base set [1, 0];
        private _groups = _groupsWithVehicles + _groupsWithoutVehicles;
        {
            private _group = _x select 1;
            _x set [0, _evacuationBaseNumber];
            _x set [4, JTC_goal_rtb];
            _x set [5, _evacuationBaseNumber];
            private _waypoint = _group addWaypoint [getMarkerPos (_evacuationBase select 0), 50];
            _waypoint setWaypointType "MOVE";
            _waypoint setWaypointSpeed "FULL";
            _group setCurrentWaypoint _waypoint;
            _group setCombatMode "YELLOW";
        } forEach _groups;
        _groups call JTC_fnc_setEntityDataVariables;
        JTC_abandonInProgressBases deleteAt (JTC_abandonInProgressBases find _baseNumber);
    } forEach JTC_abandonInProgressBases;
};

private _spawnSupportOfOneType = {
    private _alarmedBaseNumber = _this select 0;
    private _vehicleTypeCondition = _this select 1;
    private _minSpawnCount = _this select 2;
    private _parkings = [];
    private _vehicleDataArray = [];
    for "_baseNumber" from 0 to (count JTC_enemyBases) - 1 do {
        private _base = JTC_enemyBases select _baseNumber;
        if ((_base select 3 == "ok")) then {
            {
                if (_x call _vehicleTypeCondition) then {
                    _parkings pushBack (_x select 5);
                    private _vehicleData = +_x;
                    _vehicleData pushBack _baseNumber;
                    _vehicleDataArray pushBack _vehicleData;
                };
            } forEach (_base select 4);
        };
    };
    private _spawned = [];
    {
        private _group = _x select 1;
        private _parking = _x select 3;
        private _goal = _x select 4;
        private _index = _parkings find _parking;
        if ((_index >= 0) && !isNull _group && (_goal == JTC_goal_guard || _goal == JTC_goal_rtb)) then {
            _spawned pushBack _x;
        };
        _vehicleDataArray deleteAt _index;
        _parkings deleteAt _index;
    } forEach JTC_spawnedEnemies;
    while {("counterattacks" call JTC_fnc_isEscalated) && ((count _spawned) < _minSpawnCount)
            && ((count _parkings) > 0)} do {
        private _closestParkingNumber = 0;
        private _minimumParkingDistance = 100000;
        for "_parkingNumber" from 0 to (count _parkings) - 1 do {
            private _vehicleData = _vehicleDataArray select _parkingNumber;
            private _distance = (getMarkerPos (_vehicleData select 5)) distance2D
                (getMarkerPos ((JTC_enemyBases select _alarmedBaseNumber) select 0));
            if (_distance < _minimumParkingDistance) then {
                _closestParkingNumber = _parkingNumber;
                _minimumParkingDistance = _distance;
            };
        };
        private _vehicleData = _vehicleDataArray select _closestParkingNumber;
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
        _vehicleDataArray deleteAt _closestParkingNumber;
        _parkings deleteAt _closestParkingNumber;
    };
    _spawned call JTC_fnc_setEntityDataVariables;
    {
        _x set [4, JTC_goal_support];
        _x set [5, _alarmedBaseNumber];
        ["spawned %1 at base %2 to support base %3", _x call _getEntityName, _x select 0, _alarmedBaseNumber] call JTC_fnc_log;
    } forEach _spawned;
};

private _spawnSupport = {
    {
        [_x, {(_this select 0) isKindOf "Air" && (_this select 4)}, 2] call _spawnSupportOfOneType;
        [_x, {((JTC_enemyArtillery find (_this select 0)) >= 0) && (_this select 4)}, 1] call _spawnSupportOfOneType;
        JTC_supportedBases pushBackUnique _x;
    } forEach (JTC_alarmedBases select {(JTC_supportedBases find _x) < 0;});
};

private _getPlayersKnownToEnemy = {
    private _playersKnownToEnemy = [];
    {
       private _enemyKnowsAboutPlayer = _x call JTC_fnc_enemyKnowsAboutObject;
       if (_enemyKnowsAboutPlayer select 0 > 0.05 and _enemyKnowsAboutPlayer select 1  < 300) then {
            _playersKnownToEnemy pushBack [_x, _enemyKnowsAboutPlayer];
       };
    } forEach allPlayers;
    _playersKnownToEnemy;
};
private _debugMarkers = [];
private _supportActive = false;
while {true} do {
    call _spawnBases;
    call _spawnSupport;
    private _playersKnownToEnemy = if (_supportActive) then { call _getPlayersKnownToEnemy; } else {[];};
    _supportActive = false;
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
                    _supportActive = true;
                    if ((JTC_enemyArtillery find (typeOf _vehicle)) >= 0) then {
                        private _potentialArtilleryTargets = _playersKnownToEnemy select { ((_x select 1) select 1)  < 50;};
                        if ((count _potentialArtilleryTargets) > 0) then {
                            private _playerData = selectRandom _potentialArtilleryTargets;
                            private _strikePosition = (_playerData select 1) select 3;
                            private _strikeAllowed = true;
                            {
                                private _marker = _x select 0;
                                private _markerSize = markerSize _marker;
                                if ((_strikePosition distance2D (markerPos _marker)) <
                                        (100 + ((_markerSize select 0) max (_markerSize select 1)))) then {
                                    _strikeAllowed = false;
                                };
                            } forEach JTC_enemyBases;
                            if (_strikeAllowed) then {
                                _vehicle commandArtilleryFire [_strikePosition, "32Rnd_155mm_Mo_shells", 1];
                            };
                        };
                    } else {
                        if ((count waypoints _group) <= currentWaypoint _group) then {
                            private _waypoint = _group addWaypoint [getMarkerPos ((JTC_enemyBases select _target) select 0), 500];
                            _waypoint setWaypointType "SAD";
                            _group setCombatMode "RED";
                            ["SAD waypoint created"] call JTC_fnc_log;
                        };
                        {
                           private _enemyKnowsAboutPlayer = _x select 1;
                           if (_enemyKnowsAboutPlayer select 0 > 0.05 and _enemyKnowsAboutPlayer select 1  < 20) then {
                                _group reveal (_x select 0);
                           };
                        } forEach _playersKnownToEnemy;
                    };
                } else {
                    ["%1 supporting base %2 returns to base %3", _enemyEntity call _getEntityName,
                        _enemyEntity select 5, _baseNumber] call JTC_fnc_log;
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
                    private _name = if (!isNull _vehicle) then { typeOf _vehicle; } else { _group; };
                    private _markerName = format ["%1 %2", _goal, _name];
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
                        private _vehicle = vehicle _x;
                        private _spawnedEntityData = _vehicle getVariable "_data";
                        if (!isNil "_spawnedEntityData") then {
                            _spawnedEntityData set [2, objNull];
                        };
                        deleteVehicle vehicle _x;
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
    call _abandonBases;
    sleep 5;
    if (JTC_log) then {
        {
            deleteMarker _x;
        } forEach _debugMarkers;
        _debugMarkers = [];
    };
};