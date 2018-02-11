private _itemName = _this select 0;
private _itemType = _this select 1;
private _maximumCount = _this select 2;

private _currentCargo = [[],[]];
switch (_itemType) do {
    case "w": { _currentCargo = getWeaponCargo theBase;};
    case "i": { _currentCargo = getItemCargo theBase;};
    case "b": { _currentCargo = getBackpackCargo theBase;};
    case "m": { _currentCargo = getMagazineCargo theBase;};
};

private _currentItemNumber = (_currentCargo select 0) find _itemName;
private _currentCount = 0;
if (_currentItemNumber >= 0) then {
    _currentCount = (_currentCargo select 1) select _currentItemNumber;
};

if (_currentCount < _maximumCount) then {
    switch (_itemType) do {
        case "w": { theBase addWeaponCargoGlobal [_itemName, 1];};
        case "i": { theBase addItemCargoGlobal [_itemName, 1];};
        case "b": { theBase addBackpackCargoGlobal [_itemName, 1];};
        case "m": { theBase addMagazineCargoGlobal [_itemName, 1];};
    };
    ["%1 added", _itemName] call JTC_fnc_log;
};
