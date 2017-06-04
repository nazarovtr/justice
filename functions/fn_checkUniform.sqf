waitUntil {!isNil "JTC_playerData";};
private _playerData = [getPlayerUID player] call JTC_fnc_getPlayerData;
publicVariable "JTC_playerData";
private _playerDataUniform = _playerData select 1;
if (_playerDataUniform != uniform player) then {
    if (_playerDataUniform != "") then {
        player forceAddUniform _playerDataUniform;
    } else {
        removeUniform player;
    };
};