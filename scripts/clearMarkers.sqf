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
    if ((_x find "city") == 0 or (_x find "parking") == 0 or (_x find "safe_spawn") == 0) then {
        _x setMarkerAlpha 0;
    };
} forEach allMapMarkers;