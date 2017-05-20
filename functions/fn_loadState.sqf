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

private _saveName = ctrlText 1400;

systemChat _saveName;

if ((count _saveName) == 0) then {
    hint "Select a Save";
} else {
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
    private _position = [_saveName, "basePos"] call fn_loadValue;
    private _direction = [_saveName, "baseDir"] call fn_loadValue;
    [_position] call JTC_fnc_deployBase;
    {
        _x setPos _position;
    } forEach playableUnits;
    {
        _x setPos _position;
    } forEach switchableUnits;
    JTC_commanderName = name player;
    JTC_commanderId = getPlayerUID player;
    theBase addAction ["move base", "[false] call JTC_fnc_moveBase;"];
    publicVariable "JTC_commanderName";
    publicVariable "JTC_commanderId";
    closeDialog 23001;
};