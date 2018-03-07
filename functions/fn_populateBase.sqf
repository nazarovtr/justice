private _baseNumber = _this select 0;
private _base = JTC_enemyBases select _baseNumber;
private _markerName = _base select 0;
private _population = _base select 1;
private _status = _base select 3;
private _vehicleTypes = _base select 4;

private _groups = [];
private _vehicles = [];
// creating units

private  _spawnedMarkers = [];
private _populationLeft = _population;
{
    if (_baseNumber == (_x select 0)) then {
        _spawnedMarkers pushBackUnique (_x select 3);
        if (! isNull (_x select 1)) then {
            _populationLeft = _populationLeft - count units (_x select 1);
        };
    };
} forEach JTC_spawnedEnemies;

private _availableSquads = [];
if (_status == "ok") then {
    {
        private _parkingMarker = _x select 5;
        if ((_spawnedMarkers find _parkingMarker) < 0) then {
            private _vehiclePosition = markerPos _parkingMarker;
            private _vehicleDirection = markerDir _parkingMarker;
            private _vehicle = (_x select 0) createVehicle (getMarkerPos "safe_spawn");
            if ((typeOf _vehicle) find "Ammo" > 0 or (typeOf _vehicle) find "ammo" > 0) then {
                _vehicle call JTC_fnc_loadAmmoTruckWithMagazines;
            };
            _vehicle setDir _vehicleDirection;
            _vehicle setPos _vehiclePosition;
            _vehicles pushBack _vehicle;
            if ((_x select 4) and _populationLeft > 4) then {
                createVehicleCrew _vehicle;
                private _group = group ((crew _vehicle) select 0);
                _group addVehicle _vehicle;
                _groups pushBack _group;
                _populationLeft = _populationLeft - count units _group;
                JTC_spawnedEnemies pushBack [_baseNumber, _group, _vehicle, _parkingMarker, JTC_goal_guard];
            } else {
                JTC_spawnedEnemies pushBack [_baseNumber, grpNull, _vehicle, _parkingMarker, JTC_goal_parked];
            };
        };
    } forEach _vehicleTypes;
    for "_i" from 0 to (count JTC_enemySquads) - 1 do {
        _availableSquads pushBack _i;
    };
    while {_populationLeft > 0} do {
        if (_populationLeft >= JTC_enemySmallestSquadSize) then {
            private _squadNumber = selectRandom _availableSquads;
            private _squad = JTC_enemySquads select _squadNumber;
            if ((_squad select 1) <= _populationLeft) then {
                private _group = [_markerName call BIS_fnc_randomPosTrigger, JTC_enemySide, _squad select 0] call BIS_fnc_spawnGroup;
                _groups pushBack _group;
                JTC_spawnedEnemies pushBack [_baseNumber, _group, objNull, "", JTC_goal_guard];
                _populationLeft = _populationLeft - (_squad select 1);
            } else {
                _availableSquads = _availableSquads - [_squadNumber];
            };
        } else {
            private _group = createGroup JTC_enemySide;
            _group createUnit [(selectRandom JTC_enemyInfantryUnits) select 0, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
            _groups pushBack _group;
            JTC_spawnedEnemies pushBack [_baseNumber, _group, objNull, "", JTC_goal_guard];
            _populationLeft = _populationLeft - 1;
        };
    };
};

// ACE item adding
if (JTC_ace) then {
    {
        {
            if (JTC_enemyLongRangeUnits find (typeOf _x) >= 0) then {
                _x addItemToVest "ACE_RangeCard";
                if (random 1 > 0.2) then {
                    _x addItemToVest "ACE_Kestrel4500";
                }
            };
        } forEach units _x;
    } forEach _groups;
};

//creating waypoints
{
    if (!((vehicle leader _x) isKindOf "Air")) then {
        if ((random 1) > 0.4 and ((vehicle leader _x) == (leader _x))) then {
            _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
            _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
            _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
            _x addWaypoint [getPos leader _x, 0];
            [_x, 4] setWaypointType "CYCLE";
            [_x, 1] setWaypointBehaviour "SAFE";
        } else {
            _x addWaypoint [getPos leader _x, 0];
            [_x, 1] setWaypointType "HOLD";
            [_x, 1] setWaypointBehaviour "SAFE";
            {
                _x spawn {
                    sleep 10;
                    _this action ["SitDown", _this];
                }
            } forEach units _x;
        };
    }
} forEach _groups;

// death handling
{
    {
        _x setVariable ["_baseNumber", _baseNumber, true];
        _x addEventHandler ["killed", {
            private _unit = _this select 0;
            _this call JTC_fnc_defaultEnemyDeathHandler;
            private _baseNumber = _unit getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            _base set [1, (_base select 1) - 1];
            if (_base select 3 == "ok" and (1.0 * (_base select 1) / (_base select 2)) < 0.3) then {
                _base set [3, "abandoned"];
                [(_base select 2) / 2, -(_base select 2) / 2] call JTC_fnc_changeRating;
                private _baseMarker = _base select 0;
                private _marker = createMarker ["cross_" + _baseMarker, getMarkerPos _baseMarker];
                _marker setMarkerType "hd_objective";
                ["patrols"] call JTC_fnc_escalate;
                ["counterattacks"] call JTC_fnc_escalate;
            };
            publicVariable "JTC_enemyBases";
            ["Unit killed on base number %1. Population: %2", _baseNumber, JTC_enemyPopulation] call JTC_fnc_log;
        }];
        _x addEventHandler ["Hit", {
            private _unit = _this select 0;
            private _baseNumber = _unit getVariable "_baseNumber";
            JTC_alarmedBases pushBackUnique _baseNumber;
            ["alarmed base %1", _baseNumber] call JTC_fnc_log;
        }];
        _x addEventHandler ["FiredMan", {
            private _unit = _this select 0;
            private _baseNumber = _unit getVariable "_baseNumber";
            JTC_alarmedBases pushBackUnique _baseNumber;
            ["alarmed base %1", _baseNumber] call JTC_fnc_log;
        }];
    } forEach units _x;
} forEach _groups;
// vehicle event handling

{
    _x setVariable ["_baseNumber", _baseNumber, true];
    _x addMPEventHandler ["MPKilled", {
        if (isServer) then {
            private _vehicle = _this select 0;
            private _stolen = _vehicle getVariable "_stolen";
            if (isNil "_stolen") then {
                ["Enemy vehicle destroyed"] call JTC_fnc_log;
                private _baseNumber = _vehicle getVariable "_baseNumber";
                private _base = JTC_enemyBases select _baseNumber;
                [_vehicle, _base] call JTC_fnc_removeVehicleFromEnemyBase;
            };
        };
    }];
    _x addEventHandler ["Hit", {
        private _unit = _this select 0;
        private _baseNumber = _unit getVariable "_baseNumber";
        JTC_alarmedBases pushBackUnique _baseNumber;
        ["alarmed base %1", _baseNumber] call JTC_fnc_log;
    }];
} forEach _vehicles;

["Spawned %1 on %2 population %3", _groups, _markerName, _population] call JTC_fnc_log;
