private _container = _this select 0;
private _maxDistance = 15;
private _cargoLimitMode = 0; // 0 - load everything, 1 - load what fits, 2 - do not load if not fit
private _onlyHeavyVehicles = false;
private _timePerItem = 0.2;
if (count _this > 1) then {
    _maxDistance = _this select 1;
    if (count _this > 2) then {
        _cargoLimitMode = _this select 2;
        if (count _this > 3) then {
            _onlyHeavyVehicles = _this select 3;
            if (count _this > 4) then {
                _timePerItem = _this select 4;
            };
        };
    };
};
private _vehicles =  nearestObjects [_container, ["Car", "Tank", "Helicopter"], _maxDistance];
if (!(_vehicles isEqualTo [])) then {
    private _vehicle = _vehicles select 0;
    if (!_onlyHeavyVehicles || (([_vehicle] call JTC_fnc_getCargoCapacity) >= 3000 && (getMass _vehicle) > 2000)) then {
        [_container, _vehicle, false, _timePerItem, _maxDistance, _cargoLimitMode] call JTC_fnc_moveCargo;
    } else {
        hint "You need a bigger vehicle";
    };
} else {
    hint format ["No vehicles in %1 meters", _maxDistance];
}

