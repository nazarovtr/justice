private _markerName = _this select 0;
private _cityNumber = _this select 1;
private _population = _this select 2;

JTC_spawnedCities set [_cityNumber, true];

// creating units
private _scaledPopulationLeft = round(_population * JTC_civilianSpawnPercent / 100);
private _vehicleCount = round(_population / 20);
if (_population >= 2 && _scaledPopulationLeft < 2) then {
    _scaledPopulationLeft = 2;
};
if (_population >= 2 && _vehicleCount == 0 && (random 1) > 0.3) then {
    _vehicleCount = 1;
};
private _groups = [];
while {_scaledPopulationLeft > 0} do {
    private _group = createGroup civilian;
    private _unit = _group createUnit [selectRandom JTC_civilianUnits, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
    _unit forceWalk true;
    _groups pushBack _group;
    _scaledPopulationLeft = _scaledPopulationLeft - 1;
};
private _vehicles = [];
private _attemptLimit = 3 * _vehicleCount;
while {_vehicleCount > 0 && _attemptLimit > 0} do {
    private _randomPosition = _markerName call BIS_fnc_randomPosTrigger;
    private _road = [_randomPosition] call JTC_fnc_getNearestLinearRoadWithDirection;
    if (!(_road isEqualTo [])) then {
        private _direction = if (random 1 > 0.5) then {
            _road select 1;
        } else {
            (_road select 1) + 180;
        };
        private _position = (getPos (_road select 0)) getPos [3, _direction + 90];
        if ((nearestObjects [_position, ["Car"], 50]) isEqualTo[]) then {
            private _vehicle = (JTC_civilianVehicles call JTC_fnc_selectWeightedRandom) createVehicle _position;
            _vehicle setDir _direction;
            _vehicles pushBack _vehicle;
            _vehicleCount = _vehicleCount - 1;
        }
    };
    _attemptLimit = _attemptLimit - 1;
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

// event handling
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
        _x addEventHandler ["FiredNear", {
            private _unit = _this select 0;
            _unit forceWalk false;
        }];
    } forEach units _x;
} forEach _groups;

{
    _x addEventHandler ["GetIn", {
        private _vehicle = _this select 0;
        private _unit = _this select 2;
        if (isPlayer _unit) then {
            "Vehicle stolen" remoteExec ["systemChat"];
            _vehicle setVariable ["_stolen", true, true]; // do not despawn
        };
    }];
} forEach _vehicles;

(format ["Spawned %1 units and %2 vehicles on %3 population %4", _groups, _vehicles, _markerName,
 round(_population * JTC_civilianSpawnPercent / 100)]) remoteExec ["systemChat"];

// despawn handling
[_markerName, _groups, _vehicles, _cityNumber] spawn {
    private _markerName = _this select 0;
    private _groups = _this select 1;
    private _vehicles = _this select 2;
    private _cityNumber = _this select 3;
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
    (format ["Despawned %1", _markerName]) remoteExec ["systemChat"];
    JTC_spawnedCities set [_cityNumber, false];
};
