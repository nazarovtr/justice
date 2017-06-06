private _cities = [];
private _totalCityArea = 0;
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
} forEach allMapMarkers;
systemChat format ["city areas: %1", _cities];
{
    private _area = _x select 1;
    private _cityPopulation = round (JTC_civilianPopulation * _area / _totalCityArea);
    _x set [1, _cityPopulation];
} forEach _cities;
systemChat format ["city populations: %1", _cities];
JTC_cities = _cities;