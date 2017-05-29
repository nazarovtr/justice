private _source = _this select 0;
private _target = _this select 1;
private _instant = true;
private _timePerItem = 0.1;
private _maxDistance = 15;
private _cargoLimitMode = 0; // 0 - load everything, 1 - load what fits, 2 - do not load if not fit
private _silent = false;
if (count _this > 2) then {
    _instant = _this select 2;
    if (count _this > 3) then {
        _timePerItem = _this select 3;
        if (count _this > 4) then {
            _maxDistance = _this select 4;
            if (count _this > 5) then {
                _cargoLimitMode = _this select 5;
                if (count _this > 6) then {
                    _silent = _this select 6;
                };
            };
        };
    };
};

private _targetCargoCapacity = [_target] call JTC_fnc_getCargoCapacity;
private _cargoBuffer = [_source] call JTC_fnc_getContainerCargo;
if (_cargoLimitMode != 2 || loadAbs _source < _targetCargoCapacity - loadAbs _target) then {
    clearMagazineCargoGlobal _source;
    clearWeaponCargoGlobal _source;
    clearItemCargoGlobal _source;
    clearBackpackCargoGlobal _source;

    private _cargoUnitCount = count _cargoBuffer;
    scopeName "main";
    while {!(_cargoBuffer isEqualTo [])} do {
        if ((_source distance _target) > _maxDistance) then {
            if (!_silent) then {
                hint "Too far for cargo transfer";
            };
            breakTo "main";
        };
        if (_cargoLimitMode == 1 && loadAbs _target > _targetCargoCapacity) then {
            if (!_silent) then {
                hint format ["Tranferred %1 out of %2. Maximum load reached.",
                 _cargoUnitCount - (count _cargoBuffer), _cargoUnitCount];
            };
            breakTo "main";
        };
        private _cargoUnit = _cargoBuffer select 0;
        switch (_cargoUnit select 2) do {
            case "w": { _target addWeaponCargoGlobal [_cargoUnit select 0, 1];};
            case "i": { _target addItemCargoGlobal [_cargoUnit select 0, 1];};
            case "b": { _target addBackpackCargoGlobal [_cargoUnit select 0, 1];};
            case "m": { _target addMagazineCargoGlobal [_cargoUnit select 0, 1];};
        };
        _cargoBuffer = _cargoBuffer - [_cargoUnit];
        if (!_instant) then {
            if ((_cargoUnit select 1) % 10 == 0) then {
                if (!_silent) then {
                    hint format ["Tranferred %1 out of %2", _cargoUnitCount - (count _cargoBuffer), _cargoUnitCount]
                };
            };
            sleep _timePerItem;
        };
    };
    if (_cargoBuffer isEqualTo []) then {
        if (!_silent) then {
            hint "All cargo transferred";
        };
    } else {
        {
            switch (_x select 2) do {
                case "w": { _source addWeaponCargoGlobal [_x select 0, 1];};
                case "i": { _source addItemCargoGlobal [_x select 0, 1];};
                case "b": { _source addBackpackCargoGlobal [_x select 0, 1];};
                case "m": { _source addMagazineCargoGlobal [_x select 0, 1];};
            };
        } forEach _cargoBuffer;
    };
} else {
    if (!_silent) then {
        hint "Cargo does not fit.";
    };
};