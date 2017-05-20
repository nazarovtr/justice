systemChat "moving base";

private _position = _this select 0;
//respawn_west setPos _position;
_position = [_position select 0, (_position select 1) + 2, (_position select 2) + 1];
theBase setPos _position;
theLamp setPos [(_position select 0) - 2, _position select 1, _position select 2];

if (! isNil "deployBaseActionId") then {
    player removeAction deployBaseActionId;
}
