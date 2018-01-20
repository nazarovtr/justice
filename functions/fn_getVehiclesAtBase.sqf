private _vehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], JTC_baseRadius];
private _vehicleInfo = [];
{
    _vehicleInfo pushBack [typeOf _x, getPos _x, getDir _x, [_x] call JTC_fnc_getContainerCargo,
     getAllHitPointsDamage _x, fuel _x, getFuelCargo _x, getRepairCargo _x, getAmmoCargo _x,
      (JTC_vehiclesKnownToEnemy find _x) >= 0, [_x] call BIS_fnc_getVehicleCustomization];
    // TODO vehicle ammo
} forEach _vehicles;
_vehicleInfo