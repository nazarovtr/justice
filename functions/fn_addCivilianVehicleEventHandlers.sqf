private _vehicle = _this select 0;

_vehicle addEventHandler ["GetIn", {
    private _vehicle = _this select 0;
    private _unit = _this select 2;
    if (isPlayer _unit) then {
        "Vehicle stolen" remoteExec ["systemChat"];
        _vehicle setVariable ["_stolen", true, true]; // do not despawn
    };
}];