/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
 private ["_parameters"];

// Set traffic parameters.
_parameters = [
	["SIDE", civilian],
	["VEHICLES_COUNT", 10],
	["MIN_SKILL", 0.4],
	["MAX_SKILL", 0.6],
	["DEBUG", false],
	["ON_SPAWN_CALLBACK", {
	    [_this select 0] call JTC_fnc_addCivilianVehicleEventHandlers;
	    (_this select 0) call JTC_fnc_syncVehicleCustomization;
	    {
	        [_x] call JTC_fnc_addCivilianEventHandlers;
	    } forEach (_this select 1);
	}]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
