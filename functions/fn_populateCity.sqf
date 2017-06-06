private _markerName = _this select 0;
private _cityNumber = _this select 1;
private _population = _this select 2;

JTC_spawnedCities set [_cityNumber, true];

// creating units
private _scaledPopulationLeft = round(_population * JTC_civilianSpawnPercent / 100);
if (_population >= 2 && _scaledPopulationLeft < 2) then {
    _scaledPopulationLeft = 2;
};
private _groups = [];
while {_scaledPopulationLeft > 0} do {
    private _group = createGroup civilian;
    _group createUnit [selectRandom JTC_civilianUnits, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
    _groups pushBack _group;
    _scaledPopulationLeft = _scaledPopulationLeft - 1;
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
        [_x, 1] setWaypointSpeed "LIMITED";
    };
} forEach _groups;

// death handling
{
    {
        _x setVariable ["_cityNumber", _cityNumber, true];
        _x addEventHandler ["killed", {
            private _unit = _this select 0;
            if ((random 1) < 0.3) then {
                [_unit, ["Steal clothes", "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "",
                 "true", 3]] remoteExec ["addAction", 0, _unit];
            };
            private _cityNumber = _unit getVariable "_cityNumber";
            private _city = JTC_cities select _cityNumber;
            private _populationDecrease = round (100 / JTC_civilianSpawnPercent);
            _populationDecrease = _populationDecrease min (_city select 1);
            _city set [1, (_city select 1) - _populationDecrease];
            JTC_civilianPopulation = JTC_civilianPopulation - _populationDecrease;
            publicVariable "JTC_civilianPopulation";
            publicVariable "JTC_cities";
            (format ["Unit killed in city number %1. Population: %2, Bases: %3", _cityNumber, JTC_civilianPopulation, JTC_cities]) remoteExec ["systemChat"];
        }];
    } forEach units _x;
} forEach _groups;

(format ["Spawned %1 on %2 population %3", _groups, _markerName,
 round(_population * JTC_civilianSpawnPercent / 100)]) remoteExec ["systemChat"];

// despawn handling
[_markerName, _groups, _cityNumber] spawn {
    private _markerName = _this select 0;
    private _groups = _this select 1;
    private _cityNumber = _this select 2;
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
    JTC_spawnedCities set [_cityNumber, false];
};
