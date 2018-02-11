// name, value, ticks before action, action, tick condition, action condition
private _baseDeployedCondition = {
    if (!isNil "JTC_baseDeployed") then {
        JTC_baseDeployed;
    } else {
        false;
    };
};
JTC_scheduledTasks = [
    ["recruits", 0, 10, {
        ["Rectuit added"] call JTC_fnc_log;
    }, {JTC_playerReputation > 50}, {true}],
    ["small ied", 0, 20, {
        ["small ied added"] call JTC_fnc_log;
    }, {JTC_playerReputation > 100}, _baseDeployedCondition]
];
publicVariable "JTC_scheduledTasks";

waitUntil {
    sleep 1;
    !isNil("JTC_enemyBases");
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

