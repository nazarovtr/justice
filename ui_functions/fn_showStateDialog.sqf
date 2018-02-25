disableSerialization;

fn_getGlobalValue = {
    private _key = _this select 0;
    missionNamespace getVariable ["JTC_" + _key, localize "STR_JTC_unknoun"];
};

fn_getGlobalRoundedValue = {
    private _key = _this select 0;
    private _value = missionNamespace getVariable ("JTC_" + _key);
    if (isNil ("_value")) then {
        localize "STR_JTC_unknoun";
    } else {
        round _value;
    };
};

cutRsc ["JTC_StateTitle", "PLAIN", 0, true];
waitUntil {!isNull (uiNamespace getVariable "JTC_StateTitle")};
private _dialog = uiNamespace getVariable "JTC_StateTitle";
private _stateText = _dialog displayCtrl 1002;
while {true} do {
    private _undercover = ["undercoverMode"] call fn_getGlobalValue;
    switch (_undercover) do {
        case "not": { _undercover = localize "STR_JTC_undercoverNot";};
        case "civilian": { _undercover = localize "STR_JTC_undercoverCivilian";};
        case "enemy": { _undercover = localize "STR_JTC_undercoverEnemy";};
    };
    _text = format [localize "STR_JTC_stateLine",
    ["commanderName"] call fn_getGlobalValue,
    ["recruitCount"] call fn_getGlobalValue,
    ["money"] call fn_getGlobalValue,
    ["playerRating"] call fn_getGlobalRoundedValue,
    ["playerAntirating"] call fn_getGlobalRoundedValue,
    ["enemyRating"] call fn_getGlobalRoundedValue,
    ["enemyAntirating"] call fn_getGlobalRoundedValue,
    _undercover];
    _stateText ctrlSetText _text;
    _stateText ctrlCommit 0;
    sleep 1;
};