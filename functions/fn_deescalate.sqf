if (! isNil {JTC_escalation deleteAt (JTC_escalation find _this);}) then {
    publicVariable "JTC_escalation";
    ["deescalated: %1", _this] call JTC_fnc_log;
};
