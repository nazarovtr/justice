private _cargo = _this select 0;
if (typeName _cargo != "ARRAY") then {
    _cargo = [_cargo] call JTC_fnc_getContainerCargo;
};

private _mass = 0;
{
    _mass = _mass + ([_x select 0] call JTC_fnc_getItemMass);
} forEach _cargo;
_mass;
