private _container = _this select 0;
private _cargo = _this select 1;

clearMagazineCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;
clearBackpackCargoGlobal _container;

{
    switch (_x select 2) do {
        case "w": { _container addWeaponCargoGlobal [_x select 0, 1];};
        case "i": { _container addItemCargoGlobal [_x select 0, 1];};
        case "b": { _container addBackpackCargoGlobal [_x select 0, 1];};
        case "m": {
            if (count _x > 3) then {
                _container addMagazineAmmoCargo [_x select 0, 1, _x select 3];
            } else {
                _container addMagazineCargoGlobal [_x select 0, 1];
            };
        };
    };
} forEach _cargo;