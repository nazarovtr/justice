private _player = _this select 0;
private _joinInProgress = _this select 1;
[] execVM "scripts\clearMarkers.sqf";
[] execVM "scripts\undercover.sqf";
waitUntil {time > 2};
if (JTC_cheats) then {
    player addAction ["Kill", "[] call JTC_fnc_kill;"];
};
defaultUniform = uniform player;
theBase addAction ["Persistent save", "[false] call JTCUI_fnc_showSaveDialog;", [], 0, false, true, "", "true", 3];
player onMapSingleClick "[_pos] call JTCUI_fnc_togglePointOfInterest";
theCrate addAction ["Move cargo to ammobox", "[theCrate, theBase] call JTC_fnc_moveCargo;", [], 0, false, true,
    "", "true", 3];
theBase addAction ["Move closest vehicle cargo to ammobox", "[] call JTC_fnc_moveClosestVehicleCargoToAmmobox;",
    [], 0, false, true,"", "true", 3];
theBase addAction ["Move ammobox cargo to closest vehicle",
    "[theBase, 20, 0, true, 0.02] call JTC_fnc_moveCargoToClosestVehicle;", [], 0, false, true, "", "true", 3];
waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 21) then {[] call JTCUI_fnc_showUniformDialog;};"];
if (!_joinInProgress) then {
    [true] call JTCUI_fnc_showSaveDialog;
} else {
    if (!isNil "JTC_baseDeployed") then {
        player setPosASL JTC_basePosition;
        player setDir JTC_baseDirection;
    };
    if (!isNil "JTC_commanderId") then {
        if ((getPlayerUID player) == JTC_commanderId) then {
            if (!isNil "JTC_baseDeployed") then {
                if (JTC_baseDeployed) then {
                    theBase addAction ["Move base", "call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
                } else {
                    deployBaseActionId = player addAction ["Deploy base here", "[getPosASL player, getDir player] call JTC_fnc_deployBase;",
                     [], 0, false, true, "", "true", 3];
                };
            };
        };
    };
};
[] spawn JTC_fnc_checkUniform;
[] spawn JTCUI_fnc_showStateDialog;
