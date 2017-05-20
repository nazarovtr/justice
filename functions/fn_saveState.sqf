systemChat "saving state";

fn_saveValue = {
    private _saveName = _this select 0;
    private _key = _this select 1;
    private _value = _this select 2;
    profileNamespace setVariable ["JTC_" + _saveName + "_" + _key, _value];
};

private _saveName = ctrlText 1400;

if (count _saveName == 0) then {
    hint "Fill save name";
} else {
    private _saveNames = profileNamespace getVariable "JTC_saves";
    if (isNil "_saveNames") then     {
        _saveNames = [];
    };
    if (!(_saveName in _saveNames)) then {
        _saveNames pushBack _saveName;
        profileNamespace setVariable ["JTC_saves", _saveNames];
    };
    [_saveName, "date", date] call fn_saveValue;
    [_saveName, "overcast", overcast] call fn_saveValue;
    [_saveName, "basePos", getPos theOffroad] call fn_saveValue;
    [_saveName, "baseDir", getDir theOffroad] call fn_saveValue;
    saveProfileNamespace;
    closeDialog 23001;
    hint "Saved";
};
