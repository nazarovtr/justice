private _cities = [];
private _totalCityArea = 0;
private _civilianInfrastructure = [];
private _civilianParking = [];
{
    if ((_x find "city") == 0) then {
        private _markerSize =  getMarkerSize _x;
        private _markerType =  getMarkerType _x;
        private _area = 4 * (_markerSize select 0) * (_markerSize select 1);
        if (_markerType == "ellipse") then {
            _area = _area * pi / 4;
        };
        _cities pushBack [_x, _area];
        _totalCityArea = _totalCityArea + _area;
    };
    if ((_x find "civilian_5") == 0) then {
        _civilianInfrastructure pushBack [_x, 5, []];
    };
    if ((_x find "civilian_10") == 0) then {
        _civilianInfrastructure pushBack [_x, 10, []];
    };
    if ((_x find "civ_parking") == 0) then {
        _civilianParking pushBack _x;
    };
} forEach allMapMarkers;
["city areas: %1", _cities] call JTC_fnc_log;
{
    private _area = _x select 1;
    private _cityPopulation = round (JTC_civilianPopulation * _area / _totalCityArea);
    _x set [1, _cityPopulation];
} forEach _cities;
["city populations: %1", _cities] call JTC_fnc_log;
JTC_cities = _cities;
{
    private _infra = _x;
    {
        if ((markerPos _x) inArea (_infra select 0)) then {
            (_infra select 2) pushBack _x;
        };
    } forEach _civilianParking;
} forEach _civilianInfrastructure;
["civilian infrastructure: %1", _civilianInfrastructure] call JTC_fnc_log;
JTC_civilianInfrastructure = _civilianInfrastructure;