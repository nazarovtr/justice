private _unit = _this select 0;
private _killer = _this select 1;
[-0.3, -0.5] call JTC_fnc_changeRating;
[_unit, [localize "STR_JTC_loadLoot", "[_this select 0, 10, 1] call JTC_fnc_moveCargoToClosestVehicle;",
 [], 0, false, true, "", "true", 3]] remoteExec ["addAction", 0, _unit];
if ((random 1) < 0.3) then {
    [_unit, localize "STR_JTC_stealUniform"] call JTC_fnc_addStealUniformAction;
};
JTC_enemyPopulation = JTC_enemyPopulation - 1;
private _killerVehicle = vehicle _killer;
if (vehicle _killer != _killer and JTC_civilianFaction == (faction _killerVehicle)) then {
    private _enemyKnowsAboutVehicle = _killerVehicle call JTC_fnc_enemyKnowsAboutObject;
    if (_enemyKnowsAboutVehicle select 0 > 0.5 and _enemyKnowsAboutVehicle select 1  < 300) then {
        JTC_vehiclesKnownToEnemy pushBackUnique _killerVehicle;
        publicVariable "JTC_vehiclesKnownToEnemy";
        ["vehicle %1 is now known to enemy", _killerVehicle] call JTC_fnc_log;
    };
};
publicVariable "JTC_enemyPopulation";