private _baseNumber = _this select 0;
private _base = JTC_enemyBases select _baseNumber;
private _markerName = _base select 0;
private _population = _base select 1;
private _status = _base select 3;
private _vehicleTypes = _base select 4;

JTC_spawnedBases set [_baseNumber, true];

// creating units
private _populationLeft = _population;
private _groups = [];
private _vehicles = [];
private _availableSquads = [];
if (_status == "ok") then {
    {
        private _parkingMarker = _x select 5;
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
                _populationLeft = _populationLeft - (_squad select 1);
            } else {
                _availableSquads = _availableSquads - [_squadNumber];
            };
        } else {
            private _group = createGroup JTC_enemySide;
            _group createUnit [(selectRandom JTC_enemyInfantryUnits) select 0, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
            _groups pushBack _group;
            _populationLeft = _populationLeft - 1;
        };
    };
};

//creating waypoints
private _attackHelicopterCrews = [];
{
    if ((vehicle leader _x) isKindOf "Air") then {
        _attackHelicopterCrews pushBack _x;
    } else {
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

_base pushBack _attackHelicopterCrews;
publicVariable "JTC_enemyBases";

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
            };
            publicVariable "JTC_enemyBases";
            ["Unit killed on base number %1. Population: %2, Bases: %3", _baseNumber, JTC_enemyPopulation, JTC_enemyBases] call JTC_fnc_log;
        }];
        _x addEventHandler ["Hit", {
            private _unit = _this select 0;
            private _hitter = _this select 0;
            private _baseNumber = _unit getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            if ((count _base) > 5) then {
                private _attackHelicopterCrews = _base select 5;
                {
                    _x addWaypoint [position _hitter, 100];
                    [_x, 1] setWaypointType "SAD";
                    _x setCombatMode "RED";
                } forEach _attackHelicopterCrews;
                _base resize 5;
                publicVariable "JTC_enemyBases";
            };
        }];
        _x addEventHandler ["FiredMan", {
            private _unit = _this select 0;
            private _baseNumber = _unit getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            if ((count _base) > 5) then {
                private _attackHelicopterCrews = _base select 5;
                {
                    _x addWaypoint [(position _unit) getPos [300, getDir _unit], 100];
                    [_x, 1] setWaypointType "SAD";
                    _x setCombatMode "RED";
                } forEach _attackHelicopterCrews;
                _base resize 5;
                publicVariable "JTC_enemyBases";
            };
        }];
    } forEach units _x;
} forEach _groups;
// vehicle event handling

{
    _x setVariable ["_baseNumber", _baseNumber, true];
    _x addEventHandler ["Killed", {
        private _vehicle = _this select 0;
        private _stolen = _vehicle getVariable "_stolen";
        if (isNil "_stolen") then {
            ["Enemy vehicle destroyed"] call JTC_fnc_log;
            private _baseNumber = _vehicle getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            [_vehicle, _base] call JTC_fnc_removeVehicleFromEnemyBase;
        };
    }];
    _x addEventHandler ["Hit", {
        private _unit = _this select 0;
        private _hitter = _this select 0;
        private _baseNumber = _unit getVariable "_baseNumber";
        private _base = JTC_enemyBases select _baseNumber;
        if ((count _base) > 5) then {
            private _attackHelicopterCrews = _base select 5;
            {
                _x addWaypoint [position _hitter, 100];
                [_x, 1] setWaypointType "SAD";
                _x setCombatMode "RED";
            } forEach _attackHelicopterCrews;
            _base resize 5;
            publicVariable "JTC_enemyBases";
        };
    }];
} forEach _vehicles;

// theft handling

[_vehicles, _base] spawn {
    private _vehicles = _this select 0;
    while {(count _vehicles) > 0} do {
        sleep 10;
        private _base = _this select 1;
        {
            private _stolen = _x getVariable "_stolen";
            if (isNil "_stolen" and ((position _x) distance2D markerPos (_base select 0)) > 300 and (alive _x)) then {
                private _crew = crew _x;
                private _enemyCrew = false;
                {
                    if ((alive _x) and (faction _x) == JTC_enemyFaction) then {
                        _enemyCrew = true;
                    };
                } forEach _crew;
                if (!_enemyCrew) then {
                    _x setVariable ["_stolen", true, true]; // do not despawn
                    ["Enemy vehicle stolen"] call JTC_fnc_log;
                    [_x, _base] call JTC_fnc_removeVehicleFromEnemyBase;
                };
            };
        } forEach _vehicles;
    };
};


["Spawned %1 on %2 population %3", _groups, _markerName, _population] call JTC_fnc_log;

// despawn handling
[_markerName, _groups, _vehicles, _baseNumber] spawn {
    private _markerName = _this select 0;
    private _groups = _this select 1;
    private _vehicles = _this select 2;
    private _baseNumber = _this select 3;
    private _markerPos = getMarkerPos _markerName;
    waitUntil {
        sleep 10;
        !([_markerPos] call JTC_fnc_isInSpawnArea)
    };
    {
        private _group = _x;
        {
            deleteVehicle _x;
        } forEach units _group;
        deleteGroup _group;
    } forEach _groups;
    {
        private _stolen = _x getVariable "_stolen";
        if (isNil "_stolen") then {
            deleteVehicle _x;
        };
    } forEach _vehicles;
    _vehicles resize 0;
    ["Despawned %1", _markerName] call JTC_fnc_log;
    JTC_spawnedBases set [_baseNumber, false];
    private _base = JTC_enemyBases select _baseNumber;
    _base resize 5;
    publicVariable "JTC_enemyBases";
};
