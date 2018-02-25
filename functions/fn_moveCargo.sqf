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

private _targetDriver = driver _target;
private _targetHasPlayerDriver = isPlayer _targetDriver;

fn_hint = {
    hint _this;
    if (_targetHasPlayerDriver) then {
        _this remoteExec ["hint", _targetDriver]
    };
};

private _targetCargoCapacity = [_target] call JTC_fnc_getCargoCapacity;
private _cargoBuffer = [_source] call JTC_fnc_getContainerCargo;
if (_cargoLimitMode != 2 || ([_cargoBuffer] call JTC_fnc_getCargoMass) <
    (_targetCargoCapacity - ([_target] call JTC_fnc_getCargoMass))) then {
    if (_source isKindOf "Man") then {
        {
            _source removeWeaponGlobal (_x select 0);
        } forEach weaponsItems _source;
        {
            _source removeMagazineGlobal _x;
        } forEach magazines _source;
        {
            _source removeItem _x;
        } forEach items _source;
        {
            _source unassignItem _x;
            _source removeItem _x;
        } forEach ((assignedItems _source) - JTC_ignoredAssignedItems);
        removeHeadgear _source;
        removeVest _source;
        removeBackpackGlobal _source;
        private _nearestWeaponsHolders = nearestObjects [_source, ["WeaponHolderSimulated", "GroundWeaponHolder"], 3];
        if (count _nearestWeaponsHolders > 0) then {
            deleteVehicle (_nearestWeaponsHolders select 0);
        };
        if (count _nearestWeaponsHolders > 1) then {
            deleteVehicle (_nearestWeaponsHolders select 1);
        };
    } else {
        clearMagazineCargoGlobal _source;
        clearWeaponCargoGlobal _source;
        clearItemCargoGlobal _source;
        clearBackpackCargoGlobal _source;
    };

    private _cargoUnitCount = count _cargoBuffer;
    scopeName "main";
    while {!(_cargoBuffer isEqualTo [])} do {
        if ((_source distance _target) > _maxDistance) then {
            if (!_silent) then {
                (localize "STR_JTC_cargoTooFar") call fn_hint;
            };
            breakTo "main";
        };
        private _cargoUnit = _cargoBuffer select 0;
        if (_cargoLimitMode == 1 && ([_target] call JTC_fnc_getCargoMass) +
            ([_cargoUnit select 0] call JTC_fnc_getItemMass) > _targetCargoCapacity) then {
            if (!_silent) then {
                (format [localize "STR_JTC_cargoFull",
                 _cargoUnitCount - (count _cargoBuffer), _cargoUnitCount]) call fn_hint;
            };
            breakTo "main";
        };
        switch (_cargoUnit select 2) do {
            case "w": { _target addWeaponCargoGlobal [_cargoUnit select 0, 1];};
            case "i": { _target addItemCargoGlobal [_cargoUnit select 0, 1];};
            case "b": { _target addBackpackCargoGlobal [_cargoUnit select 0, 1];};
            case "m": { _target addMagazineAmmoCargo [_cargoUnit select 0, 1, _cargoUnit select 3];};
        };
        _cargoBuffer = _cargoBuffer - [_cargoUnit];
        if (!_instant) then {
            if ((_cargoUnit select 1) % 10 == 0) then {
                if (!_silent) then {
                    (format [localize "STR_JTC_cargoProgress", _cargoUnitCount - (count _cargoBuffer), _cargoUnitCount]) call fn_hint
                };
            };
            sleep _timePerItem;
        };
    };
    if (_cargoBuffer isEqualTo []) then {
        if (!_silent) then {
            (localize "STR_JTC_cargoFinish") call fn_hint;
        };
    } else {
        private _putBackContainer = _source;
        if (_source isKindOf "Man") then {
            _putBackContainer = "GroundWeaponHolder" createVehicle getPos _source;
            _putBackContainer setPos (getPos _source)
        };
        {
            switch (_x select 2) do {
                case "w": { _putBackContainer addWeaponCargoGlobal [_x select 0, 1];};
                case "i": { _putBackContainer addItemCargoGlobal [_x select 0, 1];};
                case "b": { _putBackContainer addBackpackCargoGlobal [_x select 0, 1];};
                case "m": { _putBackContainer addMagazineAmmoCargo [_x select 0, 1, _x select 3];};
            };
        } forEach _cargoBuffer;
    };
} else {
    if (!_silent) then {
        (localize "STR_JTC_cargoNoFit") call fn_hint;
    };
};
