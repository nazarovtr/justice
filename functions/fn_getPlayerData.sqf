private _playerId = _this select 0;
private _playerData = [];
scopeName "main1";
{
    if ((_x select 0) == _playerId) then {
        _playerData = _x;
        breakTo "main1";
    };
} forEach JTC_playerData;
if (_playerData isEqualTo []) then {
    scopeName "main2";
    private _player = "";
    {
        if((getPlayerUID _x) == _playerId) then {
        _player = _x;
            breakTo "main2";
        };
    } forEach allPlayers;
    _playerData = [_playerId, uniform _player];
    JTC_playerData pushBack _playerData;
};
_playerData;
