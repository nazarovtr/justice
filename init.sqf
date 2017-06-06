call compile preprocessFileLineNumbers "scripts\constants.sqf";
if (isServer) then {
    call compile preprocessFileLineNumbers "scripts\population.sqf";
    waitUntil {!isNil "paramsArray";};
    setDate [2035, 5, 12, (paramsArray select 1), 0];
    JTC_money = 97000;
    JTC_recruitCount = 82;
    JTC_spawnDistance = 1000;
    publicVariable "JTC_money";
    publicVariable "JTC_recruitCount";
    publicVariable "JTC_spawnDistance";
    JTC_defaultBasePos = getPos theBase;
    publicVariable "JTC_defaultBasePos";
    [] execVM "scripts\initTimeout.sqf";
    [] execVM "scripts\spawn.sqf";
};
[] execVM "scripts\weather.sqf";