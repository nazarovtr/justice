waitUntil {
    sleep 1;
    !isNil("JTC_enemyBases");
};
JTC_goal_parked = "parked";
JTC_goal_guard = "guard";
// [baseNumber, group, vehicle, parking, goal]
JTC_spawnedEnemies = [];
JTC_alarmedBases = [];
JTC_spawnedBases = [];

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

while {true} do {
    call _spawnBases;
    for "_enemyNumber" from (count JTC_spawnedEnemies) - 1 to 0 step -1 do {
        private _enemyEntity = JTC_spawnedEnemies select _enemyNumber;
        private _baseNumber = _enemyEntity select 0;
        private _base = JTC_enemyBases select _baseNumber;
        private _baseMarker = _base select 0;
        private _group = _enemyEntity select 1;
        private _vehicle = _enemyEntity select 2;
        private _parkingMarker = _enemyEntity select 3;
        private _goal = _enemyEntity select 4;
        private _position = if (!isNull _group) then {
            position leader _group;
        } else {
            position _vehicle;
        };
        //local helicopter fly
        if ((JTC_alarmedBases find _baseNumber) >= 0 && !(isNull _vehicle) && !(isNull _group)) then {
            if (_vehicle isKindOf "Air") then {
                if ((count waypoints _group) <= currentWaypoint _group) then {
                    _group addWaypoint [(getMarkerPos _baseMarker) getPos [random 500 , random 360], 0];
                    [_group, 1] setWaypointType "SAD";
                    _group setCombatMode "RED";
                    ["SAD waypoint created"] call JTC_fnc_log;
                };
            };
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
        //despawn
        if ((_goal == JTC_goal_guard || _goal == JTC_goal_parked)
                && !([_position, JTC_spawnDistance + 200] call JTC_fnc_isInSpawnArea)
                && !([getMarkerPos (_base select 0)] call JTC_fnc_isInSpawnArea)) then {
            JTC_spawnedBases deleteAt (JTC_spawnedBases find _baseNumber);
            JTC_alarmedBases deleteAt (JTC_alarmedBases find _baseNumber);
            if (!isNull _vehicle) then {
                private _stolen = _vehicle getVariable "_stolen";
                if (isNil "_stolen") then {
                    deleteVehicle _vehicle;
                };
            };
            if (!isNull _group) then {
                {
                    deleteVehicle _x;
                } forEach units _group;
                deleteGroup _group;
            };
            JTC_spawnedEnemies deleteAt _enemyNumber;
        };
    };
    sleep 5;
};