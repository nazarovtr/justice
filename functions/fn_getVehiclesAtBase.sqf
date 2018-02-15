private _vehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], JTC_baseRadius];
private _vehicleInfo = [];
{
    if (alive _x) then {
        private _ammo = [];
        {
            _ammo pushBack [_x select 0, _x select 1, _x select 2]
        } forEach magazinesAllTurrets _x;
        private _cargoArrays = [[_x] call JTC_fnc_getContainerCargo];
        {
            _cargoArrays pushBack ([_x select 0] call JTC_fnc_getContainerCargo);
        } forEach fullCrew [_x, ""];

        _vehicleInfo pushBack [typeOf _x, getPos _x, getDir _x, _cargoArrays call JTC_fnc_combineCargoArrays,
         getAllHitPointsDamage _x, fuel _x, getFuelCargo _x, getRepairCargo _x, getAmmoCargo _x,
          (JTC_vehiclesKnownToEnemy find _x) >= 0, [_x] call BIS_fnc_getVehicleCustomization, _ammo];
    };
} forEach _vehicles;
_vehicleInfo