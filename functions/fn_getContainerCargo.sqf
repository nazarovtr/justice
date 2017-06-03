private _container = _this select 0;

private _weaponNames = [];
private _magazinesWithAmmo = [];
private _itemNames = [];
private _backpackNames = [];
private _weaponHolderCargo = [];

if (_container isKindOf "Man") then {
    _itemNames = (assignedItems _container) - JTC_ignoredAssignedItems;
    _itemNames = _itemNames + items _container;
    _itemNames pushBack (headgear _container);
    _itemNames pushBack (vest _container);
    _magazinesWithAmmo = magazinesAmmo _container;
    _backpackNames pushBack (backpack _container);
    private _nearestWeaponsHolders = nearestObjects [_container, ["WeaponHolderSimulated", "GroundWeaponHolder"], 3];
    if (count _nearestWeaponsHolders == 1) then {
        _weaponHolderCargo = [_nearestWeaponsHolders select 0] call JTC_fnc_getContainerCargo;
    } else {
        if (count _nearestWeaponsHolders > 1) then {
            _weaponHolderCargo = [[_nearestWeaponsHolders select 0] call JTC_fnc_getContainerCargo,
             [_nearestWeaponsHolders select 0] call JTC_fnc_getContainerCargo] call JTC_fnc_combineCargoArrays;
        };
    };
} else {
    _weaponNames = weaponCargo _container;
    _magazinesWithAmmo = magazinesAmmoCargo _container;
    _itemNames = itemCargo _container;
    _backpackNames = [];
    {
        _backpackNames pushBack (_x call BIS_fnc_basicBackpack);
    } forEach backpackCargo _container;
    private _innerContainers = everyContainer _container;
    {
        _weaponNames = _weaponNames + weaponCargo (_x select 1);
        _magazinesWithAmmo = _magazinesWithAmmo + magazinesAmmoCargo (_x select 1);
        _itemNames = _itemNames + itemCargo (_x select 1);
        {
            {
                if (count _x > 0) then {
                    if (typeName _x == "ARRAY") then {
                        _magazinesWithAmmo pushBack _x;
                    } else {
                        _itemNames pushBack _x;
                    }
                };
            } forEach (_x select [1, (count _x) -1]);
        } forEach weaponsItemsCargo (_x select 1);
    } forEach _innerContainers;

    {
        {
            if (count _x > 0) then {
                if (typeName _x == "ARRAY") then {
                    _magazinesWithAmmo pushBack _x;
                } else {
                    _itemNames pushBack _x;
                }
            };
        } forEach (_x select [1, (count _x) -1]);
    } forEach weaponsItemsCargo _container;
};
private _cargo = [];
private _cargoItemNumber = 1;
{
    _cargo pushBack [[_x] call BIS_fnc_baseWeapon, _cargoItemNumber, "w"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _weaponNames;
{
    _cargo pushBack [_x, _cargoItemNumber, "i"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _itemNames;
{
    _cargo pushBack [_x call BIS_fnc_basicBackpack, _cargoItemNumber, "b"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _backpackNames;
{
    _cargo pushBack [_x select 0, _cargoItemNumber, "m", _x select 1];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _magazinesWithAmmo;
if (!(_weaponHolderCargo isEqualTo [])) then {
    _cargo = [_cargo, _weaponHolderCargo] call JTC_fnc_combineCargoArrays;
};
_cargo;