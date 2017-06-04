disableSerialization;

if (!isNull (findDisplay 23003)) then {
    closeDialog 23003;
} else {
    createDialog "JTC_UniformDialog";
    waitUntil {!isNull (findDisplay 23003);};
    private _dialog = findDisplay 23003;

    private _uniformListBox = _dialog displayCtrl 1501;

    private _uniforms = [];
    {
        if ((_x find "U_") == 0) then {
            _uniforms pushBack [_x + "|b", "Backpack: " + (getText (configFile >> "CfgWeapons" >> _x >> "displayName"))];
        };
    } forEach itemCargo backpackContainer player;
    if (vehicle player != player) then {
        {
            if ((_x find "U_") == 0) then {
                _uniforms pushBack [_x + "|v", "Vehicle: " + (getText (configFile >> "CfgWeapons" >> _x >> "displayName"))];
            };
        } forEach itemCargo vehicle player;
    };
    private _itemNumber = 0;
    {
        _uniformListBox lbAdd (_x select 1);
        lbSetData [1501, _itemNumber, _x select 0];
        _itemNumber = _itemNumber + 1;
    } forEach _uniforms;
    if (!(_uniforms isEqualTo [])) then {
        lbSetCurSel [1501, 0];
    };
}
