private _newUnit = _this select 0;
private _oldUnit = _this select 1;

removeAllWeapons _newUnit;
removeAllItems _newUnit;
removeVest _newUnit;
removeHeadgear _newUnit;
removeBackpack _newUnit;
removeUniform _newUnit;
systemChat defaultUniform;
_newUnit forceAddUniform  defaultUniform;

JTC_recruitCount = JTC_recruitCount - 1;
publicVariable "JTC_recruitCount";
if (JTC_recruitCount < 1) then {
    if (isServer) then {
        "EveryoneLost" call BIS_fnc_endMissionServer;
    } else {
        ["EveryoneLost"] remoteExec ["BIS_fnc_endMissionServer", 2]
    }
};
