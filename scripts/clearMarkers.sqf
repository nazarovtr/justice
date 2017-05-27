{
    if ((_x find "base") == 0) then {
        _x setMarkerAlpha 0;
        private _uiMarker = createMarker ["ui_" + _x, getMarkerPos _x];
        _uiMarker setMarkerType "n_installation";
        _uiMarker setMarkerText (markerText _x);
    };
} forEach allMapMarkers;