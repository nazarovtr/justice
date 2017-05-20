private _player = _this select 0;
private _joinInProgress = _this select 1;
waitUntil {time > 2};
if (!_joinInProgress) then
{
    defaultBasePos = getPos theBase;
    theBase addAction ["persistent save", "[false] call JTC_fnc_showSaveDialog;"];
    [true] call JTC_fnc_showSaveDialog;
};

[] spawn JTC_fnc_showStateDialog;
