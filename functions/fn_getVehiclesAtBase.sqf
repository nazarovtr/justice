private _vehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], 200];
private _vehicleInfo = [];
{
    _vehicleInfo pushBack [typeOf _x, getPos _x, getDir _x, [_x] call JTC_fnc_getContainerCargo,
     getAllHitPointsDamage _x, fuel _x, getFuelCargo _x, getRepairCargo _x, getAmmoCargo _x, weaponsItems _x];
    // TODO vehicle ammo
} forEach _vehicles;
_vehicleInfo