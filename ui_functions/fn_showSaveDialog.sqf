disableSerialization;

private _onStart = param[0];

private _showDialog = true;

if (isMultiplayer) then {
    private _isAdmin = serverCommandAvailable "#logout";
    private _isHost = isServer && hasInterface;
    private _adminCommander = (paramsArray select 0) == 1;
    if (_adminCommander && !_isAdmin && !_isHost) then {
        _showDialog = false;
    };
};

if (_showDialog) then {
    "JTC_commanderName" addPublicVariableEventHandler {
        closeDialog 23001;
    };
    if (!isNil "JTC_commanderName") then {
        closeDialog 23001;
    };
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

    _saveListBox ctrlSetEventHandler ["LBSelChanged", "[] call JTCUI_fnc_saveSelectorChanged"];

    if (_onStart) then {
        ctrlEnable [1600, false]; //save button
        ctrlEnable [1601, true]; //new game button
        ctrlEnable [1602, true]; //load button
        ctrlEnable [1603, false]; //cancel button
        if (isMultiplayer && (playersNumber playerSide) > 1) then {
            ctrlEnable [1604, true]; //not a commander button
        } else {
            ctrlEnable [1604, false]; //not a commander button
        };
        ctrlEnable [1605, true]; //remove button
        ctrlEnable [1400, false]; //save name input
        _dialog displaySetEventHandler ["KeyDown", "true"];
        _dialog displaySetEventHandler ["KeyUp", "true"];
    } else {
        ctrlEnable [1600, true]; //save button
        ctrlEnable [1601, false]; //new game button
        ctrlEnable [1602, false]; //load button
        ctrlEnable [1603, true]; //cancel button
        ctrlEnable [1604, false]; //not a commander button
        ctrlEnable [1605, true]; //remove button
        ctrlEnable [1400, true]; //save name input
    };
};