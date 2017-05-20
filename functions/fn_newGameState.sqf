systemChat "new game";

JTC_commanderName = name player;
JTC_commanderId = getPlayerUID player;
publicVariable "JTC_commanderName";
publicVariable "JTC_commanderId";
deployBaseActionId = player addAction ["deploy base here", "[getPos player] call JTC_fnc_deployBase;"];
closeDialog 23001;
