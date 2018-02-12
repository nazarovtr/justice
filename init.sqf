call compile preprocessFileLineNumbers "scripts\settings.sqf";
if (isServer) then {
    call compile preprocessFileLineNumbers "scripts\population.sqf";
    waitUntil {!isNil "paramsArray";};
    setDate [2040, 5, 12, (paramsArray select 1), 0];
    JTC_defaultBasePos = getPos theBase;
    publicVariable "JTC_defaultBasePos";
    theBase allowDamage false;
    theCrate allowDamage false;
    theLamp allowDamage false;
    [] execVM "scripts\initTimeout.sqf";
    [] execVM "scripts\spawn.sqf";
    [] execVM "scripts\patrols.sqf";
    [] execVM "scripts\winConditions.sqf";
    [] execVM "scripts\scheduler.sqf";
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