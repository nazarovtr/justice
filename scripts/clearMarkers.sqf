{
    if ((_x find "base") == 0) then {
        _x setMarkerAlpha 0;
        private _uiMarker = createMarker ["ui_" + _x, getMarkerPos _x];
        _uiMarker setMarkerType "o_installation";
        _uiMarker setMarkerText (markerText _x);
    };
    if ((_x find "airbase") == 0) then {
        _x setMarkerAlpha 0;
        private _uiMarker = createMarker ["ui_" + _x, getMarkerPos _x];
        _uiMarker setMarkerType "o_plane";
        _uiMarker setMarkerText (markerText _x);
    };
    if ((_x find "city") == 0 || (_x find "parking") == 0 || (_x find "civ") == 0 || (_x find "safe_spawn") == 0) then {
        _x setMarkerAlpha 0;
    };
    if ((_x find "parking_heli") == 0 || (_x find "civ_parking_heli") == 0) then {
        private _helipad = "Land_HelipadEmpty_F" createVehicle getMarkerPos _x;
        _helipad setDir markerDir _x;
    };
} forEach allMapMarkers;