disableSerialization;

fn_getGlobalValue = {
    private _key = _this select 0;
    missionNamespace getVariable ["JTC_" + _key, "unknown"];
};

cutRsc ["JTC_StateTitle", "PLAIN", 0, true];
waitUntil {!isNull (uiNameSpace getVariable "JTC_StateTitle")};
private _dialog = uiNameSpace getVariable "JTC_StateTitle";
private _stateText = _dialog displayCtrl 1002;
private _commanderName = "Not selected";
while {true} do {
    _text = format ["Commander: %1, recruits: %2, guerilla money: %3, undercover: %4", ["commanderName"] call fn_getGlobalValue,
    ["recruitCount"] call fn_getGlobalValue, ["money"] call fn_getGlobalValue, JTC_undercoverMode];
    _stateText ctrlSetText _text;
    _stateText ctrlCommit 0;
    sleep 1;
};