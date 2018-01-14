JTC_undercoverMode = "civilian"; // not, civilian, enemy
JTC_vehiclesKnownToEnemy = [];
player setCaptive true;
player addEventHandler ["GetInMan", {
    private _vehicle = _this select 2;
    private _enemyKnowsAboutPlayer = call JTC_fnc_enemyKnowsAboutPlayer;
    if (JTC_civilianFaction == faction _vehicle and JTC_undercoverMode == "not" and
     _enemyKnowsAboutPlayer select 0 > 0.5 and _enemyKnowsAboutPlayer select 1  < 300) then {
        JTC_vehiclesKnownToEnemy pushBackUnique _vehicle;
        publicVariable "JTC_vehiclesKnownToEnemy";
    };
}];
while {true} do {
    sleep 5;
    private _newUndercoverMode = "not";
    private _vest = vest player;
    private _uniform = uniform player;
    private _hmd = hmd player;
    private _headgear = headgear player;
    private _weaponEquipped = (primaryWeapon player) != "" || (handgunWeapon player) != "" || (secondaryWeapon player) != "";
    private _playerVehicle = vehicle player;
    private _playerLooksCivilian = _vest == "" && _hmd == "" && !(_headgear in JTC_helmets) &&
        (_uniform in JTC_civilianUniforms || _uniform == "") && !_weaponEquipped;
    private _playerInCleanCivilianVehicle = (JTC_civilianFaction == (faction _playerVehicle)) and (-1 == JTC_vehiclesKnownToEnemy find _playerVehicle);
    if (vehicle player == player) then {
        if (_playerLooksCivilian) then {
            _newUndercoverMode = "civilian";
        } else {
            if (_uniform in JTC_enemyUniforms) then {
                _newUndercoverMode = "enemy";
            };
        };
    } else {
        if (_playerInCleanCivilianVehicle) then {
            private _vehicleRole = assignedVehicleRole player;
            if (_playerLooksCivilian or (_vehicleRole select 0 != "cargo") or (1 == count _vehicleRole)) then {
                _newUndercoverMode = "civilian";
            };
        };
    };
    if (JTC_undercoverMode == "not" and _newUndercoverMode != "not") then {
        private _enemyKnowsAboutPlayer = call JTC_fnc_enemyKnowsAboutPlayer;
        ["enemy knows about player: %1", _enemyKnowsAboutPlayer] call JTC_fnc_log;
        if (_enemyKnowsAboutPlayer select 0 > 0.5 and _enemyKnowsAboutPlayer select 1  < 300) then {
            _newUndercoverMode = "not";
        };
    };

    JTC_undercoverMode = _newUndercoverMode;
    if (JTC_undercoverMode == "not") then {
        player setCaptive false;
    } else {
        player setCaptive true;
    };
}

