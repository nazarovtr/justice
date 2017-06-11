private _position = _this select 0;

private _minimumDistance = 100000;
private _closestCity = ["", 0];
{
    if (_position distance getMarkerPos (_x select 0) < _minimumDistance) then {
        _minimumDistance = _position distance getMarkerPos (_x select 0);
        _closestCity = _x;
    };
} forEach JTC_cities;
_closestCity;