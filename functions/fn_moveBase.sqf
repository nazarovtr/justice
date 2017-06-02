if (([theBase] call JTC_fnc_getContainerCargo) isEqualTo []) then {
    [theCrate, theBase, true, 0, 15, 0, true] call JTC_fnc_moveCargo;
    theBase setPos JTC_defaultBasePos;
    theLamp setPos [(JTC_defaultBasePos select 0) - 1, JTC_defaultBasePos select 1, JTC_defaultBasePos select 2 ];
    theCrate setPos [(JTC_defaultBasePos select 0) + 2, JTC_defaultBasePos select 1, JTC_defaultBasePos select 2 ];
    deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
    deleteMarker "hq";
    deleteMarker "hq_radius";
    JTC_baseDeployed = false;
    publicVariable "JTC_baseDeployed";
} else {
    hint "Ammobox have to be empty"
}