private _men =  nearestObjects [theBase, ["Man"], JTC_baseRadius];
private _inventory = [];
{
    if (isPlayer _x) then {
        _inventory = [_inventory, [_x] call JTC_fnc_getContainerCargo] call JTC_fnc_combineCargoArrays;
    }
} forEach _men;
_inventory