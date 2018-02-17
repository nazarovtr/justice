private _spawnAreaAnchorPositions = call JTC_fnc_getSpawnAreaAnchorPositions;
private _minX = 100000;
private _minY = 100000;
private _maxX = 0;
private _maxY = 0;
{
    private _currentX = _x select 0;
    private _currentY = _x select 1;
    if (_currentX - JTC_spawnDistance < _minX) then {
        _minX = _currentX - JTC_spawnDistance;
    };
    if (_currentX + JTC_spawnDistance > _maxX) then {
        _maxX = _currentX + JTC_spawnDistance;
    };
    if (_currentY - JTC_spawnDistance < _minY) then {
        _minY = _currentY - JTC_spawnDistance;
    };
    if (_currentY + JTC_spawnDistance > _maxY) then {
        _maxY = _currentY + JTC_spawnDistance;
    };

} forEach _spawnAreaAnchorPositions;

private _areaWidth = _maxX - _minX;
private _areaHeight = _maxY - _minY;
private _pointCountInsideSpawnArea = 0;
for "_i" from 0 to 3 do {
    private _currentX = _minX + _areaWidth / 8 + _i * _areaWidth / 4;
    for "_j" from 0 to 3 do {
        private _currentY = _minY + _areaHeight / 8 + _j * _areaHeight / 4;
        if ([[_currentX, _currentY]] call JTC_fnc_isInSpawnArea) then {
            _pointCountInsideSpawnArea = _pointCountInsideSpawnArea + 1;
        };
    };
};
_areaWidth * _areaHeight * _pointCountInsideSpawnArea / 16;