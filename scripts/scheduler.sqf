private _baseDeployedCondition = {
    if (!isNil "JTC_baseDeployed") then {
        JTC_baseDeployed;
    } else {
        false;
    };
};
// name, value, ticks before action, action, tick condition, action condition
JTC_scheduledTasks = [
    ["recruits", 0, 10, {
        call JTC_fnc_tryToAddRecruits;
    }, {JTC_playerRating > 0}, {true}],
    ["big land ied", 0, 20, {
        ["IEDLandBig_Remote_Mag", "m", 5] call JTC_fnc_tryToAddBonusItem;
    }, {JTC_playerRating > 10}, _baseDeployedCondition],
    ["small urban ied", 0, 20, {
        ["IEDUrbanSmall_Remote_Mag", "m", 10] call JTC_fnc_tryToAddBonusItem;
    }, {JTC_playerRating > 5}, _baseDeployedCondition],
    ["worker coveralls", 0, 20, {
        ["U_C_WorkerCoveralls", "i", 6] call JTC_fnc_tryToAddBonusItem;
    }, {JTC_playerRating > 3}, _baseDeployedCondition],
    ["guerilla uniform", 0, 30, {
        ["U_BG_leader", "i", 10] call JTC_fnc_tryToAddBonusItem;
    }, {JTC_playerRating > 8}, _baseDeployedCondition],
    ["civilian vehicle", 0, 20, {
        call JTC_fnc_tryToAddBonusVehicle;
    }, {JTC_playerRating > 10}, _baseDeployedCondition]
];
publicVariable "JTC_scheduledTasks";

waitUntil {
    sleep 1;
    !isNil("JTC_missionStarted");
};

while {true} do {
    sleep 60;
    {
        private _task = _x;
        if (call (_task select 4)) then {
            _task set [1, (_task select 1) + 1];
            if ((_task select 1) >= (_task select 2) and call (_task select 5)) then {
                _task set [1, 0];
                call (_task select 3);
            };
        };
    } forEach JTC_scheduledTasks;
    publicVariable "JTC_scheduledTasks";
};

