private _markerName = _this select 0;
private _baseNumber = _this select 1;
private _population = _this select 2;

JTC_spawnedBases set [_baseNumber, true];

// creating units
private _populationLeft = _population;
private _groups = [];
private _availableSquads = [];
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

//creating waypoints
{
    if ((random 1) > 0.5) then {
        _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
        _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
        _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
        _x addWaypoint [getPos leader _x, 0];
        [_x, 4] setWaypointType "CYCLE";
        [_x, 1] setWaypointBehaviour "CARELESS";
    } else {
        _x addWaypoint [getPos leader _x, 0];
        [_x, 1] setWaypointType "HOLD";
        [_x, 1] setWaypointBehaviour "CARELESS";
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
            _unit addAction ["Load loot into closest vehicle",
             "[_this select 0, 10, 1] call JTC_fnc_moveCargoToClosestVehicle;", [], 0, false, true, "", "true", 3];
            if ((random 1) < 0.3) then {
                _unit addAction ["Steal uniform",
                 "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "", "true", 3];
            };
            private _baseNumber = _unit getVariable "_baseNumber";
            private _base = JTC_enemyBases select _baseNumber;
            _base set [1, (_base select 1) - 1];
            JTC_enemyPopulation = JTC_enemyPopulation - 1;
            publicVariable "JTC_enemyPopulation";
            publicVariable "JTC_enemyBases";
            (format ["Unit killed on base number %1. Population: %2, Bases: %3", _baseNumber, JTC_enemyPopulation, JTC_enemyBases]) remoteExec ["systemChat"];
        }];
    } forEach units _x;
} forEach _groups;

(format ["Spawned %1 on %2 population %3", _groups, _markerName, _population]) remoteExec ["systemChat"];

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
    (format ["Despawned %1", _markerName]) remoteExec ["systemChat"];
    JTC_spawnedBases set [_baseNumber, false];
};
