private _vehicles =  nearestObjects [theBase, ["Car", "Tank", "Helicopter"], 20];
if (!(_vehicles isEqualTo [])) then {
    [_vehicles select 0, theBase, false, 0.05, 20] call JTC_fnc_moveCargo;
} else {
    hint "No vehicles in 20 meters"
}