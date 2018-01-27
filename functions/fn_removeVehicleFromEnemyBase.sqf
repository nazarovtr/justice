private _vehicle = _this select 0;
private _base = _this select 1;

private _vehicleType = typeOf _vehicle;
private _vehicleTypes = _base select 4;
private _numberToRemove = -1;
private _cost = 0;
scopeName "main";
for "_i" from 0 to (count _vehicleTypes) - 1 do {
    if (((_vehicleTypes select _i) select 0) == _vehicleType) then {
        _numberToRemove = _i;
        _cost = (_vehicleTypes select _i) select 2;
        breakTo "main";
    };
};
_vehicleTypes deleteAt _numberToRemove;
if (_cost > 20000 and _cost < 1000000) then {
    [3, -3] call JTC_fnc_changeReputation;
};
if (_cost >= 1000000) then {
    [10, -6] call JTC_fnc_changeReputation;
};

publicVariable "JTC_enemyBases";