systemChat "remove save";

fn_removeValue = {
    private _saveName = _this select 0;
    private _key = _this select 1;
    profileNamespace setVariable ["JTC_" + _saveName + "_" + _key, nil];
};

private _saveName = ctrlText 1400;

private _saveNames = profileNamespace getVariable "JTC_saves";
if (isNil "_saveNames") then     {
   _saveNames = [];
};
if ((_saveName in _saveNames)) then {
    [_saveName, "date"] call fn_removeValue;
    [_saveName, "overcast"] call fn_removeValue;
    [_saveName, "basePos"] call fn_removeValue;
    [_saveName, "baseDir"] call fn_removeValue; // deprecated
    [_saveName, "recruitCount"] call fn_removeValue;
    [_saveName, "money"] call fn_removeValue;
    [_saveName, "ammobox"] call fn_removeValue;
    [_saveName, "enemyBases"] call fn_removeValue;
    [_saveName, "enemyPopulation"] call fn_removeValue;
    _saveNames deleteAt (_saveNames find _saveName);
    profileNamespace setVariable ["JTC_saves", _saveNames];
    saveProfileNamespace;
};

_saveNames = profileNamespace getVariable "JTC_saves";

private _dialog = findDisplay 23001;
private _saveListBox = _dialog displayCtrl 1500;
lbClear _saveListBox;
{
    _saveListBox lbAdd _x;
} forEach _saveNames;
_saveListBox lbSetCurSel -1;
ctrlSetText [1400, ""];