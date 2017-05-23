systemChat "loading state";

fn_loadValue = {
    private _saveName1 = _this select 0;
    private _key = _this select 1;

    private _value = profileNamespace getVariable ("JTC_" + _saveName1 + "_" + _key);

    if (count _this > 2 && isNil "_value") then {
        private _defaultValue = _this select 2;
        _value = _defaultValue;
    };
    _value;
};

fn_loadAndPublishValue = {
    private _key = _this select 1;
    private _value = _this call fn_loadValue;
    missionNamespace setVariable ["JTC_" + _key, _value, true];
    _value;
};

fn_loadDateAndWeather = {
    private _date = [_saveName, "date", date] call fn_loadValue;
    if (isServer) then {
        setDate _date;
    } else {
        [_date] remoteExec ["setDate", 2]
    };
    systemChat format ["date: %1", _date];
    private _overcast = [_saveName, "overcast", overcast] call fn_loadAndPublishValue;
    0 setOvercast _overcast;
    forceWeatherChange;
};

fn_loadBasePosition = {
    private _position = [_saveName, "basePos"] call fn_loadValue;
    [_position] call JTC_fnc_deployBase;
    {
        _x setPos _position;
    } forEach playableUnits;
    {
        _x setPos _position;
    } forEach switchableUnits;
};

fn_loadAmmobox = {
    private _cargo = [_saveName, "ammobox", []] call fn_loadValue;
    if (!(_cargo isEqualTo [])) then {
        clearMagazineCargoGlobal theBase;
        clearWeaponCargoGlobal theBase;
        clearItemCargoGlobal theBase;
        clearBackpackCargoGlobal theBase;
    };
    {
        switch (_x select 2) do {
            case "w": { theBase addWeaponCargoGlobal [_x select 0, 1];};
            case "i": { theBase addItemCargoGlobal [_x select 0, 1];};
            case "b": { theBase addBackpackCargoGlobal [_x select 0, 1];};
            case "m": { theBase addMagazineCargoGlobal [_x select 0, 1];};
        };
    } forEach _cargo;
};

fn_loadGuerillaResources = {
    [_saveName, "recruitCount", 82] call fn_loadAndPublishValue;
    [_saveName, "money", 97000] call fn_loadAndPublishValue;
};

fn_setCommander = {
    JTC_commanderName = name player;
    JTC_commanderId = getPlayerUID player;
    theBase addAction ["Move base", "[false] call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
    publicVariable "JTC_commanderName";
    publicVariable "JTC_commanderId";
};

private _saveName = ctrlText 1400;

systemChat _saveName;

if ((count _saveName) == 0) then {
    hint "Select a Save";
} else {
    [] call fn_loadDateAndWeather;
    [] call fn_loadBasePosition;
    [] call fn_loadAmmobox;
    [] call fn_loadGuerillaResources;
    [] call fn_setCommander;
    closeDialog 23001;
};