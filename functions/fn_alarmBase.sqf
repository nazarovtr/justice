private _unit = _this;
private _baseNumber = _unit getVariable "_baseNumber";
if (((JTC_enemyBases select _baseNumber) select 3) == "ok") then {
    JTC_alarmedBases pushBackUnique _baseNumber;
    ["alarmed base %1", _baseNumber] call JTC_fnc_log;
};
