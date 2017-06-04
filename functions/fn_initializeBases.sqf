private _enemyBases = [];
private _totalBaseArea = 0;
{
    if ((_x find "base") == 0) then {
        private _markerSize =  getMarkerSize _x;
        private _markerType =  getMarkerType _x;
        private _area = 4 * (_markerSize select 0) * (_markerSize select 1);
        if (_markerType == "ellipse") then {
            _area = _area * pi / 4;
        };
        _enemyBases pushBack [_x, sqrt _area]; // TODO sqrt - temporary solution for small bases
        _totalBaseArea = _totalBaseArea + sqrt _area;
    };
} forEach allMapMarkers;
systemChat format ["areas: %1", _enemyBases];
private _topBasePopulation = 0.7 * JTC_enemyPopulation;
private _actualBasePopulation = 0;
{
    private _area = _x select 1;
    private _basePopulation = floor (_topBasePopulation * _area / _totalBaseArea);
    if (_basePopulation >= 4) then {
        _x set [1, _basePopulation];
        _actualBasePopulation = _actualBasePopulation + _basePopulation;
    } else {
        _x set [1, 0];
    };
} forEach _enemyBases;
systemChat format ["populations: %1", _enemyBases];
JTC_enemyBases = _enemyBases;
JTC_freeEnemyPopulation = JTC_enemyPopulation - _actualBasePopulation;