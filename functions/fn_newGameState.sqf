systemChat "new game";

JTC_commanderName = name player;
JTC_commanderId = getPlayerUID player;
JTC_enemyPopulation = 29;
JTC_enemyBases = [] call JTC_fnc_initializeBases;
publicVariable "JTC_commanderName";
publicVariable "JTC_commanderId";
publicVariable "JTC_enemyPopulation";
publicVariable "JTC_enemyBases";
theBase addAction ["Move base", "[false] call JTC_fnc_moveBase;", [], 0, false, true, "", "true", 3];
deployBaseActionId = player addAction ["Deploy base here", "[getPos player] call JTC_fnc_deployBase;", [], 0, false, true, "", "true", 3];
private _marker = createMarker ["hq", getMarkerPos JTC_respawnMarker];
_marker setMarkerType JTC_hqMarkerType;
_marker setMarkerText (markerText "Home");
closeDialog 23001;
