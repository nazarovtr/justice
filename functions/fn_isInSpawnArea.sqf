private _position = _this select 0;
private _distance = JTC_spawnDistance;
if (count _this > 1) then {
    _distance = _this select 1;
};

private _spawnAreaAnchorPositions = call JTC_fnc_getSpawnAreaAnchorPositions;

private _result = false;
scopeName "main";
{
    if (_position distance2D _x < _distance) then {
        _result = true;
        breakTo "main";
    };
} forEach _spawnAreaAnchorPositions;
_result;