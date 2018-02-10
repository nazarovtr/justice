JTC_recruitCount = JTC_recruitCount - 1;
publicVariable "JTC_recruitCount";
if (JTC_recruitCount < 1) then {
    if (isServer) then {
        "noRecruits" call BIS_fnc_endMissionServer;
    } else {
        ["noRecruits"] remoteExec ["BIS_fnc_endMissionServer", 2];
    };
};
