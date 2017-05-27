private _enemyBases = [];
{
    if ((_x find "base") == 0) then {
        _enemyBases pushBack [_x, 0];
    };
} forEach allMapMarkers;

private _uneven = JTC_enemyPopulation % count _enemyBases;
{
    if (_uneven > 0) then {
        _x set [1, 1 + floor (JTC_enemyPopulation / count _enemyBases)];
        _uneven = _uneven - 1;
    } else {
        _x set [1, floor (JTC_enemyPopulation / count _enemyBases)];
    }
} forEach _enemyBases;

_enemyBases;