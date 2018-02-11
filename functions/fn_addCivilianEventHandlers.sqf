private _civilian = _this select 0;

_civilian addEventHandler ["killed", {
    if (!isNil "JTC_cities") then {
        private _unit = _this select 0;
        if (isPlayer (_this select 1)) then {
            [-10, 5] call JTC_fnc_changeReputation;
        };
        if ((random 1) < 0.3) then {
            [_unit, ["Steal clothes", "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "",
             "true", 3]] remoteExec ["addAction", 0, _unit];
        };

        private _city = [position _unit] call JTC_fnc_getClosestCity;
        private _populationDecrease = 1;
        _populationDecrease = _populationDecrease min (_city select 1);
        _city set [1, (_city select 1) - _populationDecrease];
        JTC_civilianPopulation = JTC_civilianPopulation - _populationDecrease;
        if ((random JTC_civilianPopulation) < JTC_recruitablePopulation) then {
            JTC_recruitablePopulation = JTC_recruitablePopulation - _populationDecrease;
        };
        JTC_civilianPopulation = JTC_civilianPopulation - _populationDecrease;
        publicVariable "JTC_civilianPopulation";
        publicVariable "JTC_recruitablePopulation";
        publicVariable "JTC_cities";
        ["Unit killed in city %1. Population: %2, Bases: %3", _city select 0, JTC_civilianPopulation,
         JTC_cities] call JTC_fnc_log;
    };
}];

_civilian addEventHandler ["FiredNear", {
    private _unit = _this select 0;
    _unit forceWalk false;
}];