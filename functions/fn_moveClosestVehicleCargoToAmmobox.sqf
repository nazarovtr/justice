private _vehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], 20];
if (!(_vehicles isEqualTo [])) then {
    [_vehicles select 0, theBase, false, 0.02, 20] call JTC_fnc_moveCargo;
} else {
    hint format [localize "STR_JTC_cargoNoVehicle", 20]
}