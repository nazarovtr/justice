if ((lbCurSel 1501) >= 0) then {
    private _dataSplit = [lbData [1501, lbCurSel 1501], "|"] call BIS_fnc_splitString;
    private _newUniform = _dataSplit select 0;
    private _container = if ((_dataSplit select 1) == "b") then {
        backpackContainer player;
    } else {
        vehicle player;
    };
    if (loadUniform player > 0) then {
        if (vehicle player != player) then {
            [uniformContainer player, vehicle player, true, 0.1, 15, 0, true] call JTC_fnc_moveCargo;
            hint "Loaded uniform items into vehicle";
        } else {
            private _weaponHolder = "GroundWeaponHolder" createVehicle getPos player;
            _weaponHolder setPos (getPos player);
            [uniformContainer player, _weaponHolder, true, 0.1, 15, 0, true] call JTC_fnc_moveCargo;
            hint "Dropped uniform items to the ground";
        }
    };
    private _oldUniform = uniform player;
    player forceAddUniform _newUniform;
    private _playerData = [getPlayerUID player] call JTC_fnc_getPlayerData;
    _playerData set [1, _newUniform];
    publicVariable "JTC_playerData";
    if (_container == vehicle player) then {
        [_container, [[_newUniform, 1]]] call JTC_fnc_removeItems;
    } else {
        player removeItem _newUniform;
    };
    _container addItemCargoGlobal [_oldUniform, 1];
    closeDialog 23003;
    hint "Uniform changed";
} else {
    hint "Select a uniform";
}