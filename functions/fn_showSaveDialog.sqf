disableSerialization;

private _onStart = param[0];

private _saveNames = profileNamespace getVariable "JTC_saves";
if (isNil "_saveNames") then {
    _saveNames = [];
};

createDialog "JTC_SaveDialog";
waitUntil {!isNull (findDisplay 23001);};
private _dialog = findDisplay 23001;

private _saveListBox = _dialog displayCtrl 1500;

{
    _saveListBox lbAdd _x;
} forEach _saveNames;

_saveListBox ctrlSetEventHandler ["LBSelChanged", "[_this] call JTC_fnc_saveSelectorChanged"];

if (_onStart) then {
    ctrlEnable [1600, false]; //save button
    ctrlEnable [1601, true]; //new game button
    ctrlEnable [1602, true]; //load button
    ctrlEnable [1603, false]; //cancel button
    ctrlEnable [1400, false]; //save name input
} else {
    ctrlEnable [1600, true]; //save button
    ctrlEnable [1601, false]; //new game button
    ctrlEnable [1602, false]; //load button
    ctrlEnable [1603, true]; //cancel button
    ctrlEnable [1400, true]; //save name input
}