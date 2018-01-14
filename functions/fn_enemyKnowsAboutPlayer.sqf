private _maxKnowledge = 0;
private _positionError = 0;
private _minPositionError = 10000;
private _playerPosition = position player;
{
    if (JTC_enemySide == side _x) then {
        private _knowsAbout = _x knowsAbout player;
        if (_maxKnowledge <= _knowsAbout) then {
            _maxKnowledge = _knowsAbout;
        };
        _positionError = (leader _x getHideFrom player) distance _playerPosition;
        if (_positionError < _minPositionError) then {
            _minPositionError = _positionError;
        };
    };
} forEach allGroups;

[_maxKnowledge, _minPositionError];