private _newUnit = _this select 0;
private _oldUnit = _this select 1;

removeAllWeapons _newUnit;
removeAllItems _newUnit;
removeVest _newUnit;
removeHeadgear _newUnit;
removeBackpack _newUnit;
removeUniform _newUnit;
if (!isNil "JTC_baseDeployed") then {
    _newUnit setPosASL JTC_basePosition;
    _newUnit setDir JTC_baseDirection;
};
if ((random 1) < 1) then {
    [_oldUnit, localize "STR_JTC_recoverUniform"] call JTC_fnc_addStealUniformAction;
};
_newUnit forceAddUniform  defaultUniform;
private _playerData = [getPlayerUID player] call JTC_fnc_getPlayerData;
_playerData set [1, defaultUniform];
publicVariable "JTC_playerData";
if ((getPlayerUID player) == JTC_commanderId) then {
    if (isNil "JTC_baseDeployed") then {
        deployBaseActionId = player addAction [localize "STR_JTC_deployBase", "[getPosASL player, getDir player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
    } else {
        if (!JTC_baseDeployed) then {
            deployBaseActionId = player addAction [localize "STR_JTC_deployBase", "[getPosASL player, getDir player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
        }
    };
};

[-2, 3] call JTC_fnc_changeRating;
call JTC_fnc_handleRecruitDeath;
