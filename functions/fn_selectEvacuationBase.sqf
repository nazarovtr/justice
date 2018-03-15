private _evacuatedBase = _this;

private _okBaseNumbers = [];
for "_baseNumber" from 0 to (count JTC_enemyBases) - 1 do {
    private _base = JTC_enemyBases select _baseNumber;
    if ((_base select 3 == "ok")) then {
        _okBaseNumbers pushBack _baseNumber;
    };
};
selectRandom _okBaseNumbers;