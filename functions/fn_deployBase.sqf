private _position = _this select 0;
private _direction = _this select 1;

JTC_respawnMarker setMarkerPos _position;

deleteMarker "hq";
deleteMarker "hq_radius";
private _marker = createMarker ["hq_radius", _position];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [JTC_baseRadius, JTC_baseRadius];
_marker setMarkerAlpha 0.4;
_marker = createMarker ["hq", getMarkerPos JTC_respawnMarker];
_marker setMarkerType JTC_hqMarkerType;
_marker setMarkerText "HQ";
private _basePosition = _position getPos [1.5, _direction];
private _lampPosition = _position getPos [1.5, _direction + 90];
private _cratePosition = _position getPos [1.5, _direction + 180];
theBase setPosASL [_basePosition select 0, _basePosition select 1, _position select 2];
theLamp setPosASL [_lampPosition select 0, _lampPosition select 1, _position select 2];
theCrate setPosASL [_cratePosition select 0, _cratePosition select 1, _position select 2];
JTC_baseDeployed = true;
JTC_basePosition = _position;
JTC_baseDirection = _direction;
publicVariable "JTC_baseDeployed";
publicVariable "JTC_basePosition";
publicVariable "JTC_baseDirection";

if (! isNil "deployBaseActionId") then {
    player removeAction deployBaseActionId;
}
