private _body = _this select 0;
private _uniform = uniform _body;
private _backpack = backpack player;
if (_backpack != "") then {
    private _initialLoad = loadBackpack player;
    player addItem _uniform;
    if ((loadBackpack player) != _initialLoad) then {
        private _putBackContainer = "GroundWeaponHolder" createVehicle getPos _body;
        _putBackContainer setPos (getPos _body);
        [uniformContainer _body, _putBackContainer, true, 0.1, 15, 0, true] call JTC_fnc_moveCargo;
        removeUniform _body;
    } else {
        hint "Not enough space in your backpack";
    };
} else {
    hint "You need a backpack";
};
