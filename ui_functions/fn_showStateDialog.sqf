disableSerialization;

fn_getGlobalValue = {
    private _key = _this select 0;
    missionNamespace getVariable ["JTC_" + _key, "unknown"];
};

fn_getGlobalRoundedValue = {
    private _key = _this select 0;
    private _value = missionNamespace getVariable ("JTC_" + _key);
    if (isNil ("_value")) then {
        "unknown";
    } else {
        round _value;
    };
};

cutRsc ["JTC_StateTitle", "PLAIN", 0, true];
waitUntil {!isNull (uiNamespace getVariable "JTC_StateTitle")};
private _dialog = uiNamespace getVariable "JTC_StateTitle";
private _stateText = _dialog displayCtrl 1002;
while {true} do {
    _text = format ["Commander: %1, recruits: %2, money: %3, rtg: %4, a-rtg: %5, enemy rtg: %6, enemy a-rtg: %7, undercover: %8",
    ["commanderName"] call fn_getGlobalValue,
    ["recruitCount"] call fn_getGlobalValue,
    ["money"] call fn_getGlobalValue,
    ["playerRating"] call fn_getGlobalRoundedValue,
    ["playerAntirating"] call fn_getGlobalRoundedValue,
    ["enemyRating"] call fn_getGlobalRoundedValue,
    ["enemyAntirating"] call fn_getGlobalRoundedValue,
    ["undercoverMode"] call fn_getGlobalValue];
    _stateText ctrlSetText _text;
    _stateText ctrlCommit 0;
    sleep 1;
};