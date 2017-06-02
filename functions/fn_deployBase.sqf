private _position = _this select 0;
JTC_respawnMarker setMarkerPos _position;

_position = [_position select 0, (_position select 1) + 2, (_position select 2) + 1];
deleteMarker "hq";
deleteMarker "hq_radius";
private _marker = createMarker ["hq_radius", _position];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [JTC_baseRadius, JTC_baseRadius];
_marker setMarkerAlpha 0.4;
_marker = createMarker ["hq", getMarkerPos JTC_respawnMarker];
_marker setMarkerType JTC_hqMarkerType;
_marker setMarkerText "HQ";
theBase setPos _position;
theLamp setPos [(_position select 0) - 2, _position select 1, _position select 2];
theCrate setPos [(_position select 0) + 2, _position select 1, _position select 2];
JTC_baseDeployed = true;
publicVariable "JTC_baseDeployed";

if (! isNil "deployBaseActionId") then {
    player removeAction deployBaseActionId;
}
