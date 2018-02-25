["loading state"] call JTC_fnc_log;

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
    private _direction = [_saveName, "baseDir"] call fn_loadValue;
    [_position, _direction] call JTC_fnc_deployBase;
    {
        _x setPosASL _position;
        _x setDir _direction;
    } forEach playableUnits;
    {
        _x setPosASL _position;
        _x setDir _direction;
    } forEach switchableUnits;
};

fn_loadPopulation = {
    [_saveName, "enemyPopulation", 150] call fn_loadAndPublishValue;
    [_saveName, "civilianPopulation", 1500] call fn_loadAndPublishValue;
    [_saveName, "recruitablePopulation", 600] call fn_loadAndPublishValue;
    [_saveName, "civilianSpawnPercent", 10] call fn_loadAndPublishValue;
    [_saveName, "freeEnemyPopulation", 50] call fn_loadAndPublishValue;
    [_saveName, "cities", []] call fn_loadAndPublishValue;
    [_saveName, "civilianInfrastructure", []] call fn_loadAndPublishValue;
    [_saveName, "enemyBases", []] call fn_loadAndPublishValue;
};

fn_loadReputation = {
    [_saveName, "playerRating", JTC_defaultPlayerRating] call fn_loadAndPublishValue;
    [_saveName, "playerAntirating", JTC_defaultPlayerAntirating] call fn_loadAndPublishValue;
    [_saveName, "enemyRating", JTC_defaultEnemyRating] call fn_loadAndPublishValue;
    [_saveName, "enemyAntirating", JTC_defaultEnemyAntirating] call fn_loadAndPublishValue;
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
    [_saveName, "deadRecruitCount", 0] call fn_loadAndPublishValue;
    [_saveName, "money", 97000] call fn_loadAndPublishValue;
    [_saveName, "playerData", []] call fn_loadAndPublishValue;
};

fn_setCommander = {
    JTC_commanderName = name player;
    JTC_commanderId = getPlayerUID player;
    theBase addAction [localize "STR_JTC_moveBase", "call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
    publicVariable "JTC_commanderName";
    publicVariable "JTC_commanderId";
};

fn_removeStartingVehicles = {
    {
        deleteVehicle _x;
    } forEach JTC_startingVehicles;
};

fn_loadSchedulerData = {
    private _schedulerData = [_saveName, "schedulerData"] call fn_loadValue;
    {
        private _data = _x;
        {
            if ((_data select 0) == (_x select 0)) then {
                _x set [1, _data select 1];
            };
        } forEach JTC_scheduledTasks;
    } forEach _schedulerData;
    publicVariable "JTC_scheduledTasks";
};

private _saveName = ctrlText 1400;

[_saveName] call JTC_fnc_log;

if ((count _saveName) == 0) then {
    hint localize "STR_JTC_selectASave";
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
    [] call fn_loadSchedulerData;
    {
        if ((_x find "start") == 0) then {
            _x setMarkerAlpha 0;
        };
    } forEach allMapMarkers;
    closeDialog 23001;
};