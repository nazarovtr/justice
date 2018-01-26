private _enemyBases = [];
private _totalSqrtBaseArea = 0;
private _totalBaseArea = 0;
{
    if ((_x find "base") == 0) then {
        private _markerSize =  getMarkerSize _x;
        private _markerType =  getMarkerType _x;
        private _area = 4 * (_markerSize select 0) * (_markerSize select 1);
        if (_markerType == "ellipse") then {
            _area = _area * pi / 4;
        };
        _enemyBases pushBack [_x, sqrt _area, _area]; // TODO sqrt - temporary solution for small bases
        _totalSqrtBaseArea = _totalSqrtBaseArea + sqrt _area;
        _totalBaseArea = _totalBaseArea + _area;
    };
} forEach allMapMarkers;
["areas: %1", _enemyBases] call JTC_fnc_log;
private _topBasePopulation = 0.7 * JTC_enemyPopulation;
private _vehiclePool = [];
{
    for "_i" from 1 to (_x select 1) do {
    	_vehiclePool pushBack _x;
    };
} forEach JTC_enemyVehicles;
_vehiclePool = _vehiclePool call JTC_fnc_arrayShuffle;
private _actualBasePopulation = 0;
private _vehicleCount = count _vehiclePool;
{
    private _sqrtArea = _x select 1;
    private _area = _x select 2;
    private _basePopulation = floor (_topBasePopulation * _sqrtArea / _totalSqrtBaseArea);
    private _baseVehicleCount = round (_vehicleCount * _area / _totalBaseArea);
    private _baseVehicles = [];
    for "_i" from 1 to _baseVehicleCount do {
        if (count _vehiclePool > 0) then {
            _baseVehicles pushBack (_vehiclePool deleteAt 0);
        };
    };
    if (_basePopulation >= 4) then {
        _x set [1, _basePopulation];
        _x set [2, _basePopulation]; // normal base population
        _x pushBack "ok"; // base status
        _x pushBack _baseVehicles; // base vehicles
        _actualBasePopulation = _actualBasePopulation + _basePopulation;
    } else {
        _x set [1, 0];
        _x set [2, 0]; // normal base population
        _x pushBack "abandoned"; // base status
        _x pushBack [];
    };
    _x pushBack []; // parking markers
} forEach _enemyBases;
if (count _vehiclePool > 0) then {
    {
        ((selectRandom _enemyBases) select 4) pushBack _x;
    } forEach _vehiclePool;
};
{
    private _marker = _x;
    if ((_x find "parking") == 0) then {
        {
            if ((markerPos _marker) inArea (_x select 0)) then {
                (_x select 5) pushBack _marker;
            };
        } forEach _enemyBases;
    };
} forEach allMapMarkers;
["populations: %1", _enemyBases] call JTC_fnc_log;
JTC_enemyBases = _enemyBases;
JTC_freeEnemyPopulation = JTC_enemyPopulation - _actualBasePopulation;