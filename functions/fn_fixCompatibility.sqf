private _fixOneItemIfNeeded = {
    private _key = _this select 0;
    private _fixFunction = _this select 1;
    if ((JTC_compatibility find _key) < 0) then {
        call _fixFunction;
        JTC_compatibility pushBackUnique _key;
        ["Compatibility fixed: %1", _key] call JTC_fnc_log;
    } else {
        ["Already compatible: %1", _key] call JTC_fnc_log;
    };
};

[JTC_comp_patrolsAndCounterattacks, {
    scopeName "main";
    {
        if ((_x select 3) == "abandoned") then {
            ["patrols"] call JTC_fnc_escalate;
            ["counterattacks"] call JTC_fnc_escalate;
            breakTo "main";
        };
    } forEach JTC_enemyBases;
}] call _fixOneItemIfNeeded;

[JTC_comp_smallerRepLoss, {
    [10, 0] call JTC_fnc_changeRating;
    JTC_playerAntirating = JTC_playerAntirating / 2;
}] call _fixOneItemIfNeeded;