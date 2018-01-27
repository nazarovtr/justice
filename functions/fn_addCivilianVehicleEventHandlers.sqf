private _vehicle = _this select 0;

_vehicle addEventHandler ["GetIn", {
    private _vehicle = _this select 0;
    private _unit = _this select 2;
    private _stolen = _vehicle getVariable "_stolen";
    if (isPlayer _unit and isNil "_stolen") then {
        ["Civilian vehicle stolen"] call JTC_fnc_log;
        _vehicle setVariable ["_stolen", true, true]; // do not despawn
        [-5, 2] call JTC_fnc_changeReputation;
    };
}];

_vehicle addEventHandler ["Killed", {
    private _vehicle = _this select 0;
    private _killer = _this select 1;
    private _stolen = _vehicle getVariable "_stolen";
    if (isPlayer _killer and isNil "_stolen") then {
        ["Civilian vehicle destroyed"] call JTC_fnc_log;
        [-5, 2] call JTC_fnc_changeReputation;
    };
}];