private _maxKnowledge = 0;
private _positionError = 0;
private _minPositionError = 10000;
private _observationDistance = 10000;
private _bestPercievedPosition = [0, 0, 0];
private _mostInformedGroup = grpNull;
private _objectPosition = position _this;
{
    if (JTC_enemySide == side _x and ({ alive _x } count units _x) > 0) then {
        private _knowsAbout = _x knowsAbout _this;
        if (_maxKnowledge <= _knowsAbout) then {
            _maxKnowledge = _knowsAbout;
        };
        private _percievedPosition = leader _x getHideFrom _this;
        _positionError = _percievedPosition distance _objectPosition;
        if (_positionError < _minPositionError) then {
            _minPositionError = _positionError;
            _observationDistance = (position leader _x) distance _percievedPosition;
            _bestPercievedPosition = _percievedPosition;
            _mostInformedGroup = _x;
        };
    };
} forEach allGroups;

private _result = [_maxKnowledge, _minPositionError, _observationDistance, _bestPercievedPosition, _mostInformedGroup];
["enemy knows about %1: %2", _this, _result] call JTC_fnc_log;
_result;