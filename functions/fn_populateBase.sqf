private _baseNumber = _this select 0;
private _base = JTC_enemyBases select _baseNumber;
private _markerName = _base select 0;
private _population = _base select 1;
private _status = _base select 3;

JTC_spawnedBases set [_baseNumber, true];

// creating units
private _populationLeft = _population;
private _groups = [];
private _availableSquads = [];
if (_status == "ok") then {
    for "_i" from 0 to (count JTC_enemySquads) - 1 do {
        _availableSquads pushBack _i;
    };
    while {_populationLeft > 0} do {
        if (_populationLeft >= JTC_enemySmallestSquadSize) then {
            private _squadNumber = selectRandom _availableSquads;
            private _squad = JTC_enemySquads select _squadNumber;
            if ((_squad select 1) <= _populationLeft) then {
                private _group = [_markerName call BIS_fnc_randomPosTrigger, JTC_enemySide, _squad select 0] call BIS_Fnc_spawnGroup;
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
{
    if ((random 1) > 0.5) then {
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
} forEach _groups;

// death handling
{
    {
        _x setVariable ["_baseNumber", _baseNumber, true];
        _x addEventHandler ["killed", {
            private _unit = _this select 0;
            [-1, -2] call JTC_fnc_changeReputation;
            [_unit, ["Load loot into closest vehicle", "[_this select 0, 10, 1] call JTC_fnc_moveCargoToClosestVehicle;",
             [], 0, false, true, "", "true", 3]] remoteExec ["addAction", 0, _unit];
            if ((random 1) < 0.3) then {
                [_unit, ["Steal uniform", "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "",
                 "true", 3]] remoteExec ["addAction", 0, _unit];
            };
            private _baseNumber = _unit getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            _base set [1, (_base select 1) - 1];
            if (_base select 3 == "ok" and (1.0 * (_base select 1) / (_base select 2)) < 0.3) then {
                _base set [3, "abandoned"];
                [_base select 2, -2 * (_base select 2)] call JTC_fnc_changeReputation;
            };
            JTC_enemyPopulation = JTC_enemyPopulation - 1;
            publicVariable "JTC_enemyPopulation";
            publicVariable "JTC_enemyBases";
            ["Unit killed on base number %1. Population: %2, Bases: %3", _baseNumber, JTC_enemyPopulation, JTC_enemyBases] call JTC_fnc_log;
        }];
    } forEach units _x;
} forEach _groups;

["Spawned %1 on %2 population %3", _groups, _markerName, _population] call JTC_fnc_log;

// despawn handling
[_markerName, _groups, _baseNumber] spawn {
    private _markerName = _this select 0;
    private _groups = _this select 1;
    private _baseNumber = _this select 2;
    private _markerPos = getMarkerPos _markerName;
    waitUntil {
        sleep 3;
        !([_markerPos] call JTC_fnc_isInSpawnArea)
    };
    {
        private _group = _x;
        {
            deleteVehicle _x;
        } forEach units _group;
        deleteGroup _group;
    } forEach _groups;
    ["Despawned %1", _markerName] call JTC_fnc_log;
    JTC_spawnedBases set [_baseNumber, false];
};
