systemChat "saving state";

private _saveName = ctrlText 1400;

if (count _saveName == 0) then {
    hint "Fill save name";
} else {
    private _saveNames = profileNamespace getVariable "JTC_saves";
    if (isNil "_saveNames") then {
        _saveNames = [];
    };
    if (!(_saveName in _saveNames)) then {
        _saveNames pushBack _saveName;
        profileNamespace setVariable ["JTC_saves", _saveNames];
    };
    profileNamespace setVariable ["JTC_" + _saveName + "_basePos", getPos theOffroad];
    profileNamespace setVariable ["JTC_" + _saveName + "_baseDir", getDir theOffroad];
    saveProfileNamespace;
    closeDialog 23001;
    hint "Saved";
};
