private _vehicle = _this select 0;

_vehicle addEventHandler ["GetIn", {
    private _vehicle = _this select 0;
    private _unit = _this select 2;
    private _stolen = _vehicle getVariable "_stolen";
    if (isPlayer _unit and isNil "_stolen") then {
        ["Vehicle stolen"] call JTC_fnc_log;
        _vehicle setVariable ["_stolen", true, true]; // do not despawn
        [-5, 2] call JTC_fnc_changeReputation;
    };
}];