disableSerialization;

cutRsc ["JTC_StateTitle", "PLAIN", 0, true];
waitUntil {!isNull (uiNameSpace getVariable "JTC_StateTitle")};
private _dialog = uiNameSpace getVariable "JTC_StateTitle";
private _stateText = _dialog displayCtrl 1002;
private _commanderName = "Not selected";
while {true} do
{
    if (!isNil "JTC_commanderName") then
    {
        _commanderName = JTC_commanderName;
    };
    _text = format ["Commander: %1", _commanderName];
    _stateText ctrlSetText _text;
    _stateText ctrlCommit 0;
    sleep 1;
};