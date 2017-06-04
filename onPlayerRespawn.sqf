private _newUnit = _this select 0;
private _oldUnit = _this select 1;

removeAllWeapons _newUnit;
removeAllItems _newUnit;
removeVest _newUnit;
removeHeadgear _newUnit;
removeBackpack _newUnit;
removeUniform _newUnit;
if ((random 1) < 1) then {
    [_oldUnit, ["Recover uniform", "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "",
     "true", 3]] remoteExec ["addAction", 0, _oldUnit];
};
_newUnit forceAddUniform  defaultUniform;
private _playerData = [getPlayerUID player] call JTC_fnc_getPlayerData;
_playerData set [1, defaultUniform];
publicVariable "JTC_playerData";

JTC_recruitCount = JTC_recruitCount - 1;
publicVariable "JTC_recruitCount";
if (JTC_recruitCount < 1) then {
    if (isServer) then {
        "noRecruits" call BIS_fnc_endMissionServer;
    } else {
        ["noRecruits"] remoteExec ["BIS_fnc_endMissionServer", 2];
    };
};

// TODO remove cheats
player onMapSingleClick "if (_alt) then {player setPosATL _pos}";
