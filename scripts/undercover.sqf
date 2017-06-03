JTC_undercoverMode = "civilian"; // not, civilian, enemy
player setCaptive true;
while {true} do {
    sleep 5;
    private _newUndercoverMode = "not";
    private _vest = vest player;
    private _uniform = uniform player;
    private _hmd = hmd player;
    private _headgear = headgear player;
    private _weaponEquipped = (primaryWeapon player) != "" || (handgunWeapon player) != "" || (secondaryWeapon player) != "";
    private _playerLooksCivilian = _vest == "" && _hmd == "" && !(_headgear in JTC_helmets) && _uniform in JTC_civilianUniforms
                               && !_weaponEquipped;
    if (_playerLooksCivilian || JTC_civilianFaction == (faction vehicle player)) then {
        _newUndercoverMode = "civilian";
    } else {
        if (_uniform in JTC_enemyUniforms) then {
            _newUndercoverMode = "enemy";
        };
    };
    JTC_undercoverMode = _newUndercoverMode;
    if (JTC_undercoverMode == "not") then {
        player setCaptive false;
    } else {
        player setCaptive true;
    };
}

