waitUntil {time > 120 || !isNil "JTC_commanderName"};
if (isNil "JTC_commanderName") then {
    "noCommander" call BIS_fnc_endMissionServer;
};
