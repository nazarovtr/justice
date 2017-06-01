/*
Author: Fett_Li

Description:
	This script returns the "room" an item/weapon takes.

Parameter(s):
	_this select 0:
	STRING - item

Returns:
	NUMBER - mass of the item
*/

private _item = _this select 0;
private _mass = 0;

if (isClass (configFile >> "CfgWeapons" >> _item)) then {
    if (isClass (configFile >> "CfgWeapons" >> _item >> "weaponSlotsInfo")) then {
        _mass = getNumber (configFile >> "CfgWeapons" >> _item >> "weaponSlotsInfo" >> "mass");
    } else {
        _mass = getNumber (configFile >> "CfgWeapons" >> _item >> "itemInfo" >> "mass");
    };
} else {
    if (isClass (configFile >> "CfgMagazines" >> _item)) then {
        _mass = getNumber (configFile >> "CfgMagazines" >> _item >> "mass");
    } else {
        _mass = getNumber (configFile >> "CfgVehicles" >> _item >> "mass");
    };
};
_mass