if (isServer) then {
    waitUntil {!isNil "paramsArray";};
    setDate [2035, 5, 12, (paramsArray select 1), 0];
};

[] execVM "scripts\weather.sqf";