private _skipAmount = if (_this > 0) then {
    _this
} else {
    if (_this == -1) then {
        6 - (date select 3);
    } else {
        21 - (date select 3);
    };
};
if (_skipAmount < 0) then {
    _skipAmount = _skipAmount + 24;
};
scopeName "main";
private _skip = true;
{
    private _player = _x;
    if (!((position _player) inArea "hq_radius")) then {
        _skip = false;
        hint "Not all players are on the base";
        breakTo "main";
    };
    private _enemyKnowsAboutPlayer = _player call JTC_fnc_enemyKnowsAboutObject;
    if (_enemyKnowsAboutPlayer select 0 > 0.05 and _enemyKnowsAboutPlayer select 1  < 300) then {
        _skip = false;
        hint "There is an enemy who knows about player position";
        breakTo "main";
    };
} forEach allPlayers;
if (_skip) then {
    _skipAmount remoteExec ["skipTime", 2];
};