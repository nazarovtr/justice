private _infraNumber = _this select 0;
private _infra = JTC_civilianInfrastructure select _infraNumber;
private _markerName = _infra select 0;
private _population = _infra select 1;

JTC_spawnedInfrastructure set [_infraNumber, true];

// creating units
private _populationLeft = _population;
private _groups = [];
private _vehicles = [];
{
    if ((random 1) > 0.5) then {
        private _parkingMarker = _x;
        private _vehiclePosition = markerPos _parkingMarker;
        private _vehicleDirection = markerDir _parkingMarker;
        private _vehicleType = JTC_civilianVehicles call JTC_fnc_selectWeightedRandom;
        if ((_x find "heli") > 0) then {
            _vehicleType = selectRandom JTC_civilianHelicopters;
        };
        if ((_x find "plane") > 0) then {
            _vehicleType = selectRandom JTC_civilianPlanes;
        };
        private _vehicle = _vehicleType createVehicle (getMarkerPos "safe_spawn");
        _vehicle setDir _vehicleDirection;
        _vehicle setPos _vehiclePosition;
        _vehicles pushBack _vehicle;
    };
} forEach (_infra select 2);

while {_populationLeft > 0} do {
    private _group = createGroup civilian;
    private _unit = _group createUnit [selectRandom JTC_civilianUnits, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
    _unit forceWalk true;
    _groups pushBack _group;
    _populationLeft = _populationLeft - 1;
};

//creating waypoints
{
    _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
    _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
    _x addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
    _x addWaypoint [getPos leader _x, 0];
    [_x, 4] setWaypointType "CYCLE";
    [_x, 1] setWaypointBehaviour "SAFE";
    [_x, 1] setWaypointSpeed "LIMITED";
} forEach _groups;

// event handling
{
    {
        [_x] call JTC_fnc_addCivilianEventHandlers;
    } forEach units _x;
} forEach _groups;

{
    [_x] call JTC_fnc_addCivilianVehicleEventHandlers;
} forEach _vehicles;

["Spawned %1 units and %2 vehicles on %3 population %4", _groups, _vehicles, _markerName, _population] call JTC_fnc_log;

// despawn handling
[_markerName, _groups, _vehicles, _infraNumber] spawn {
    private _markerName = _this select 0;
    private _groups = _this select 1;
    private _vehicles = _this select 2;
    private _infraNumber = _this select 3;
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
    {
        private _stolen = _x getVariable "_stolen";
        if (isNil "_stolen") then {
            deleteVehicle _x;
        };
    } forEach _vehicles;
    ["Despawned %1", _markerName] call JTC_fnc_log;
    JTC_spawnedInfrastructure set [_infraNumber, false];
};