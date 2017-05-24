private _player = _this select 0;
private _joinInProgress = _this select 1;
waitUntil {time > 2};
defaultUniform = uniform player;
theBase addAction ["Persistent save", "[false] call JTC_fnc_showSaveDialog;", [], 0, false, true, "", "true", 3];
theCrate addAction ["Move cargo to ammobox", "[theCrate, theBase] call JTC_fnc_moveCargo;", [], 0, false, true,
    "", "true", 3];
if (!_joinInProgress) then {
    defaultBasePos = getPos theBase;

    [true] call JTC_fnc_showSaveDialog;
} else {
    if (!isNil "JTC_baseDeployed") then {
        if (JTC_baseDeployed) then {
            player setPos (getMarkerPos "respawn_west");
        };
    };
    if (!isNil "JTC_commanderId") then {
        if ((getPlayerUID player) == JTC_commanderId) then {
            if (!isNil "JTC_baseDeployed") then {
                if (JTC_baseDeployed) then {
                    theBase addAction ["Move base", "[false] call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
                } else {
                    deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;",
                     [], 0, false, true, "", "true", 3];
                };
            };
        };
    };
};

[] spawn JTC_fnc_showStateDialog;
