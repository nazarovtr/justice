private _baseVehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], JTC_baseRadius];
private _civilianVehicleCount = 0;
{
    if (JTC_civilianFaction == (faction _x)) then {
        _civilianVehicleCount = _civilianVehicleCount + 1;
    };
} forEach _baseVehicles;
if (_civilianVehicleCount < 4) then {
    private _position = JTC_basePosition getPos [30, random 360];
    private _vehicle = (JTC_civilianVehicles call JTC_fnc_selectWeightedRandom) createVehicle _position;
    _vehicle call JTC_fnc_syncVehicleCustomization;
    ["bonus vehicle %1 added", _vehicle] call JTC_fnc_log;
};