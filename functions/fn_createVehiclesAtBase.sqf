JTC_vehiclesKnownToEnemy = [];
private _vehicles = _this select 0;
{
    private _vehicle = (_x select 0) createVehicle (getMarkerPos "safe_spawn");
    _vehicle setDir (_x select 2);
    _vehicle setPos (_x select 1);
    [_vehicle, _x select 3] call JTC_fnc_setContainerCargo;
    private _damage = _x select 4;
    for "_hitPointNumber" from 0 to (count (_damage select 0)) - 1 do {
        _vehicle setHitPointDamage [(_damage select 0) select _hitPointNumber,
         (_damage select 2) select _hitPointNumber, false];
    };
    _vehicle setFuel (_x select 5);
    if (finite (_x select 6)) then {
        _vehicle setFuelCargo (_x select 6);
        _vehicle addAction ["Check fuel cargo", "hint format [""%1"", getFuelCargo(_this select 0)]",
         [], 0, false, true, "", "true", 3];
    };
    if (finite  (_x select 7)) then {
        _vehicle setRepairCargo (_x select 7);
        _vehicle addAction ["Check repair cargo", "hint format [""%1"", getRepairCargo(_this select 0)]",
         [], 0, false, true, "", "true", 3];
    };
    if (finite (_x select 8)) then {
        _vehicle setRepairCargo (_x select 8);
        _vehicle addAction ["Check ammo cargo", "hint format [""%1"", getAmmoCargo(_this select 0)]",
         [], 0, false, true, "", "true", 3];
    };
    if (_x select 9) then {
        JTC_vehiclesKnownToEnemy pushBack _vehicle;
    };
    if (count _x > 10) then {
        [_vehicle, (_x select 10) select 0, (_x select 10) select 1] call BIS_fnc_initVehicle;
    };
    if (count _x > 11) then {
        private _ammo = _x select 11;
        {
            _vehicle removeMagazinesTurret [_x select 0, _x select 1];
        } forEach _ammo;
        {
            _vehicle addMagazineTurret [_x select 0, _x select 1, _x select 2];
        } forEach _ammo;
    };
} forEach _vehicles;
publicVariable "JTC_vehiclesKnownToEnemy";