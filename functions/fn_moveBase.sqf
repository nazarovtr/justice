systemChat "moving base";

theBase setPos JTC_defaultBasePos;
theLamp setPos [(JTC_defaultBasePos select 0) - 1, JTC_defaultBasePos select 1, JTC_defaultBasePos select 2 ];
theCrate setPos [(JTC_defaultBasePos select 0) + 2, JTC_defaultBasePos select 1, JTC_defaultBasePos select 2 ];
deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
JTC_baseDeployed = false;
publicVariable "JTC_baseDeployed";