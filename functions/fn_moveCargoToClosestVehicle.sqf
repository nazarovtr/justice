systemChat "moving ammobox";
private _container = _this select 0;
private _maxDistance = 15;
private _cargoLimitMode = 0; // 0 - load everything, 1 - load what fits, 2 - do not load if not fit
private _onlyHeavyVehicles = false;
if (count _this > 1) then {
    _maxDistance = _this select 1;
    if (count _this > 2) then {
        _cargoLimitMode = _this select 2;
        if (count _this > 3) then {
            _onlyHeavyVehicles = _this select 3;
        };
    };
};
private _vehicles =  nearestObjects [_container, ["Car", "Tank", "Helicopter"], _maxDistance];
if (!(_vehicles isEqualTo [])) then {
    private _vehicle = _vehicles select 0;
    if (!_onlyHeavyVehicles || (([_vehicle] call JTC_fnc_getCargoCapacity) >= 3000 && (getMass _vehicle) > 2000)) then {
        [theBase, _vehicle, false, 0.2, _maxDistance, _cargoLimitMode] call JTC_fnc_moveCargo;
    } else {
        hint "You need a bigger vehicle";
    };
} else {
    hint "No vehicles in 20 meters"
}

