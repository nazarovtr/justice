systemChat "moving base";

theBase setPos defaultBasePos;
theLamp setPos [(defaultBasePos select 0) - 1, defaultBasePos select 1, defaultBasePos select 2 ];
theCrate setPos [(defaultBasePos select 0) + 2, defaultBasePos select 1, defaultBasePos select 2 ];
deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
JTC_baseDeployed = false;
publicVariable "JTC_baseDeployed";