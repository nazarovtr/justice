systemChat "saving state";

fn_saveValue = {
    private _saveName = _this select 0;
    private _key = _this select 1;
    private _value = _this select 2;
    profileNamespace setVariable ["JTC_" + _saveName + "_" + _key, _value];
};

fn_saveSaveNames = {
    private _saveNames = profileNamespace getVariable "JTC_saves";
    if (isNil "_saveNames") then     {
        _saveNames = [];
    };
    if (!(_saveName in _saveNames)) then {
        _saveNames pushBack _saveName;
        profileNamespace setVariable ["JTC_saves", _saveNames];
    };
};

private _saveName = ctrlText 1400;

if (count _saveName == 0) then {
    hint "Fill save name";
} else {
    [] call fn_saveSaveNames;
    [_saveName, "date", date] call fn_saveValue;
    [_saveName, "overcast", overcast] call fn_saveValue;

    private _position = getPos theBase;
    [_saveName, "basePos", [_position select 0, (_position select 1) - 2, _position select 2]] call fn_saveValue;

    [_saveName, "recruitCount", JTC_recruitCount] call fn_saveValue;
    [_saveName, "money", JTC_money] call fn_saveValue;
    [theCrate, theBase, true, 0, 15, 0, true] call JTC_fnc_moveCargo;
    [_saveName, "ammobox", [theBase] call JTC_fnc_getContainerCargo] call fn_saveValue;
    [_saveName, "vehicles", [theBase] call JTC_fnc_getVehiclesAtBase] call fn_saveValue;
    [_saveName, "enemyBases", JTC_enemyBases] call fn_saveValue;
    [_saveName, "enemyPopulation", JTC_enemyPopulation] call fn_saveValue;
    saveProfileNamespace;
    closeDialog 23001;
    hint "Saved";
};
