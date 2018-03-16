private _unit = _this;
private _spawnedEntityData = _unit getVariable "_data";
private _baseNumber = _spawnedEntityData select 0;
private _goal = _spawnedEntityData select 4;
if (((JTC_enemyBases select _baseNumber) select 3) == "ok" && _goal == JTC_goal_guard) then {
    JTC_alarmedBases pushBackUnique _baseNumber;
    ["alarmed base %1", _baseNumber] call JTC_fnc_log;
};
