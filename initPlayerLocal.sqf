private _player = _this select 0;
private _joinInProgress = _this select 1;
waitUntil {time > 2};
if (!_joinInProgress) then {
    systemChat "jip";
    [true] call JTC_fnc_showSaveDialog;
};
