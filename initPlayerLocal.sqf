private _player = _this select 0;
private _joinInProgress = _this select 1;
waitUntil {time > 2};
defaultUniform = uniform player;
systemChat defaultUniform;
if (!_joinInProgress) then
{
    defaultBasePos = getPos theBase;
    theBase addAction ["persistent save", "[false] call JTC_fnc_showSaveDialog;", [], 0, false, true, "", "true", 3];
    [true] call JTC_fnc_showSaveDialog;
} else {
    if (!isNil "JTC_baseDeployed") then {
        if (JTC_baseDeployed) then {
            player setPos (getMarkerPos "respawn_west");
        };
    };
};

[] spawn JTC_fnc_showStateDialog;
