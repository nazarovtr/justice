call compile preprocessFileLineNumbers "scripts\constants.sqf";
if (isServer) then {
    call compile preprocessFileLineNumbers "scripts\population.sqf";
    waitUntil {!isNil "paramsArray";};
    setDate [2035, 5, 12, (paramsArray select 1), 0];
    JTC_money = 97000;
    JTC_recruitCount = 82;
    JTC_spawnDistance = 1000;
    JTC_pointsOfInterest = [];
    JTC_pointOfInterestNumber = 0;
    publicVariable "JTC_money";
    publicVariable "JTC_recruitCount";
    publicVariable "JTC_spawnDistance";
    publicVariable "JTC_pointsOfInterest";
    publicVariable "JTC_pointOfInterestNumber";
    JTC_defaultBasePos = getPos theBase;
    theBase allowDamage false;
    theCrate allowDamage false;
    theLamp allowDamage false;
    publicVariable "JTC_defaultBasePos";
    [] execVM "scripts\initTimeout.sqf";
    [] execVM "scripts\spawn.sqf";
    [] execVM "scripts\winConditions.sqf";
};
[] execVM "scripts\weather.sqf";

call compile preprocessFileLineNumbers "Engima\Traffic\Common\Common.sqf";
call compile preprocessFileLineNumbers "Engima\Traffic\Common\Debug.sqf";

ENGIMA_TRAFFIC_instanceIndex = -1;
ENGIMA_TRAFFIC_areaMarkerNames = [];
ENGIMA_TRAFFIC_roadSegments = [];
ENGIMA_TRAFFIC_edgeTopLeftRoads = [];
ENGIMA_TRAFFIC_edgeTopRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomLeftRoads = [];
ENGIMA_TRAFFIC_edgeRoadsUseful = [];

if (isServer) then {
	call compile preprocessFileLineNumbers "Engima\Traffic\Server\Functions.sqf";
	call compile preprocessFileLineNumbers "Engima\Traffic\ConfigAndStart.sqf";
};