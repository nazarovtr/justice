systemChat "new game";

JTC_commanderName = name player;
JTC_commanderId = getPlayerUID player;
publicVariable "JTC_commanderName";
publicVariable "JTC_commanderId";
theBase addAction ["Move base", "[false] call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
closeDialog 23001;
