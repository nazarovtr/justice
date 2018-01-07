systemChat "loading state";

fn_loadValue = {
    private _saveName1 = _this select 0;
    private _key = _this select 1;

    private _value = profileNamespace getVariable ("JTC_" + _saveName1 + "_" + _key);

    if (count _this > 2 && isNil "_value") then {
        private _defaultValue = _this select 2;
        _value = _defaultValue;
    };
    if (typeName _value == "ARRAY") then {
        _value = +_value;
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

fn_loadPopulation = {
    [_saveName, "enemyPopulation", 150] call fn_loadAndPublishValue;
    [_saveName, "civilianPopulation", 1500] call fn_loadAndPublishValue;
    [_saveName, "civilianSpawnPercent", 10] call fn_loadAndPublishValue;
    [_saveName, "freeEnemyPopulation", 50] call fn_loadAndPublishValue;
    [_saveName, "cities", []] call fn_loadAndPublishValue;
    [_saveName, "enemyBases", []] call fn_loadAndPublishValue;
};

fn_loadReputation = {
    [_saveName, "playerReputation", JTC_defaultPlayerReputation] call fn_loadAndPublishValue;
    [_saveName, "enemyReputation", JTC_defaultEnemyReputation] call fn_loadAndPublishValue;
};

fn_loadAmmobox = {
    private _cargo = [_saveName, "ammobox", []] call fn_loadValue;
    [theBase, _cargo] call JTC_fnc_setContainerCargo;
};

fn_loadVehicles = {
    private _vehicles = [_saveName, "vehicles", []] call fn_loadValue;
    [_vehicles] call JTC_fnc_createVehiclesAtBase;
};

fn_loadGuerillaResources = {
    [_saveName, "recruitCount", 82] call fn_loadAndPublishValue;
    [_saveName, "money", 97000] call fn_loadAndPublishValue;
    [_saveName, "playerData", []] call fn_loadAndPublishValue;
};

fn_setCommander = {
    JTC_commanderName = name player;
    JTC_commanderId = getPlayerUID player;
    theBase addAction ["Move base", "[false] call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
    publicVariable "JTC_commanderName";
    publicVariable "JTC_commanderId";
};

fn_removeStartingVehicles = {
    {
        deleteVehicle _x;
    } forEach JTC_startingVehicles;
};

private _saveName = ctrlText 1400;

systemChat _saveName;

if ((count _saveName) == 0) then {
    hint "Select a Save";
} else {
    [] call fn_setCommander;
    [] call fn_removeStartingVehicles;
    [] call fn_loadDateAndWeather;
    [] call fn_loadBasePosition;
    [] call fn_loadAmmobox;
    [] call fn_loadVehicles;
    [] call fn_loadGuerillaResources;
    [] call fn_loadPopulation;
    [] call fn_loadReputation;
    closeDialog 23001;
};