private _stage = _this select 0;
private _condition = true;
if (count _this >= 2) then {
    private _dependencies = _this select 1;
    scopeName "main";
    {
        if ((JTC_escalation find _x) < 0) then {
            _condition = false;
            ["Not escalated to: %1, dependency %2 not met", _stage] call JTC_fnc_log;
            breakTo "main";
        };
    } forEach _dependencies;
};
if (_condition) then {
    if ((JTC_escalation pushBackUnique _stage) >= 0) then {
        publicVariable "JTC_escalation";
        ["escalated to: %1", _stage] call JTC_fnc_log;
    };
};