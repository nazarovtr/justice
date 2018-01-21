JTC_undercoverMode = "civilian"; // not, civilian, enemy
JTC_vehiclesKnownToEnemy = [];
player setCaptive true;
while {true} do {
    sleep 5;
    private _newUndercoverMode = "not";
    private _playerPosition = position player;
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
        private _enemyKnowsAboutPlayer = player call JTC_fnc_enemyKnowsAboutObject;
        if (_enemyKnowsAboutPlayer select 0 > 0.5 and _enemyKnowsAboutPlayer select 1  < 300) then {
            _newUndercoverMode = "not";
        };
    };

    if (_newUndercoverMode == "civilian" and !isNil("JTC_enemyBases")) then {
        {
            if (_playerPosition inArea (_x select 0)) then {
                _newUndercoverMode = "not";
            };
        } forEach JTC_enemyBases;
    };

    if (_newUndercoverMode != "not" and alive player) then {
        scopeName "main";
        {
            if ((_playerPosition distance position _x) < 20) then {
                _newUndercoverMode = "not";
                breakTo "main";
            }
        } forEach getAllOwnedMines player;
    };

    if (_newUndercoverMode != "not" and alive player) then {
        scopeName "main";
        {
            if (faction _x == JTC_enemyFaction && !alive _x) then {
                _newUndercoverMode = "not";
                breakTo "main";
            };
        } forEach (_playerPosition nearObjects ["man", 15]);
    };

    if (_playerInCleanCivilianVehicle and _newUndercoverMode == "not") then {
        private _enemyKnowsAboutPlayer = _playerVehicle call JTC_fnc_enemyKnowsAboutObject;
        if (_enemyKnowsAboutPlayer select 0 > 0.5 and _enemyKnowsAboutPlayer select 1  < 300) then {
            JTC_vehiclesKnownToEnemy pushBackUnique _playerVehicle;
            publicVariable "JTC_vehiclesKnownToEnemy";
            ["vehicle %1 is now known to enemy", _playerVehicle] call JTC_fnc_log;
        };
    };

    JTC_undercoverMode = _newUndercoverMode;
    if (JTC_undercoverMode == "not") then {
        player setCaptive false;
    } else {
        player setCaptive true;
    };
}

