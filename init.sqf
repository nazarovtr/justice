if (isServer) then {
    waitUntil {!isNil "paramsArray";};
    setDate [2035, 5, 12, (paramsArray select 1), 0];
    JTC_money = 97000;
    JTC_recruitCount = 82;
    publicVariable "JTC_money";
    publicVariable "JTC_recruitCount";
    [] execVM "scripts\initTimeout.sqf";
};
[] execVM "scripts\weather.sqf";