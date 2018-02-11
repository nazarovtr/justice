["saving state"] call JTC_fnc_log;

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

    [_saveName, "basePos", JTC_basePosition] call fn_saveValue;
    [_saveName, "baseDir", JTC_baseDirection] call fn_saveValue;

    [_saveName, "recruitCount", JTC_recruitCount] call fn_saveValue;
    [_saveName, "deadRecruitCount", JTC_deadRecruitCount] call fn_saveValue;
    [_saveName, "money", JTC_money] call fn_saveValue;
    [theCrate, theBase, true, 0, 15, 0, true] call JTC_fnc_moveCargo;
    [_saveName, "ammobox", [[theBase] call JTC_fnc_getContainerCargo,
     [] call JTC_fnc_getPlayersAtBaseBaseInventory] call JTC_fnc_combineCargoArrays] call fn_saveValue;
    [_saveName, "vehicles", [theBase] call JTC_fnc_getVehiclesAtBase] call fn_saveValue;
    [_saveName, "enemyBases", JTC_enemyBases] call fn_saveValue;
    [_saveName, "cities", JTC_cities] call fn_saveValue;
    [_saveName, "playerRating", JTC_playerRating] call fn_saveValue;
    [_saveName, "playerAntirating", JTC_playerAntirating] call fn_saveValue;
    [_saveName, "enemyRating", JTC_enemyRating] call fn_saveValue;
    [_saveName, "enemyAntirating", JTC_enemyAntirating] call fn_saveValue;
    [_saveName, "enemyPopulation", JTC_enemyPopulation] call fn_saveValue;
    [_saveName, "civilianPopulation", JTC_civilianPopulation] call fn_saveValue;
    [_saveName, "recruitablePopulation", JTC_recruitablePopulation] call fn_saveValue;
    [_saveName, "civilianSpawnPercent", JTC_civilianSpawnPercent] call fn_saveValue;
    [_saveName, "freeEnemyPopulation", JTC_freeEnemyPopulation] call fn_saveValue;
    {
        private _playerData = [getPlayerUID _x] call JTC_fnc_getPlayerData;
        _playerData set [1, uniform _x];
    } forEach allPlayers;
    publicVariable "JTC_playerData";
    [_saveName, "playerData", JTC_playerData] call fn_saveValue;
    private _schedulerData = [];
    {
        _schedulerData pushBack [_x select 0, _x select 1];
    } forEach JTC_scheduledTasks;
    [_saveName, "schedulerData", _schedulerData] call fn_saveValue;
    saveProfileNamespace;
    closeDialog 23001;
    hint "Saved";
};
