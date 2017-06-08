private _position = _this select 0;
private _radius = 50;
if (count _this > 1) then {
    _radius = _this select 1;
};
private _roads = _position nearRoads _radius;
private _result = [];
scopeName "main";
{
    private _connectedRoads = roadsConnectedTo _x;
    if ((count _connectedRoads) == 2 && (count (roadsConnectedTo (_connectedRoads select 0))) == 2
        && (count (roadsConnectedTo (_connectedRoads select 1))) == 2) then {
        _result = [_x, [_connectedRoads select 0, _connectedRoads select 1] call BIS_fnc_DirTo];
        breakTo "main";
    };
} forEach _roads;
_result;
