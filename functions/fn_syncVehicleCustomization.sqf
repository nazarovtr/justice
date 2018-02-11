private _vehicle = _this;
private _customization = [_vehicle] call BIS_fnc_getVehicleCustomization;
[_vehicle, _customization select 0, _customization select 1] call BIS_fnc_initVehicle;
