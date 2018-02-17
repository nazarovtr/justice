private _enemyBases = [];
private _totalBaseArea = 0;
private _groundParking = [];
private _heliParking = [];
private _planeParking = [];
private _uavParking = [];
{
    if ((_x find "base") == 0 or (_x find "airbase") == 0) then {
        private _markerSize =  getMarkerSize _x;
        private _markerType =  getMarkerType _x;
        private _area = 4 * (_markerSize select 0) * (_markerSize select 1);
        if (_markerType == "ellipse") then {
            _area = _area * pi / 4;
        };
        _area = sqrt _area; // TODO sqrt - temporary solution for small bases
        if ((_x find "airbase") == 0) then {
            _area = _area / 2;
        };
        _enemyBases pushBack [_x, _area, []];
        _totalBaseArea = _totalBaseArea + _area;
    };
    if ((_x find "parking_ground") == 0) then {
        _groundParking pushBack _x;
    };
    if ((_x find "parking_heli") == 0) then {
        _heliParking pushBack _x;
    };
    if ((_x find "parking_plane") == 0) then {
        _planeParking pushBack _x;
    };
    if ((_x find "parking_uav") == 0) then {
        _uavParking pushBack _x;
    };
} forEach allMapMarkers;
["areas: %1", _enemyBases] call JTC_fnc_log;
private _topBasePopulation = 0.7 * JTC_enemyPopulation;
private _groundVehiclePool = JTC_enemyGroundVehicles call JTC_fnc_generateVehiclePool;
private _heliPool = JTC_enemyHelicopters call JTC_fnc_generateVehiclePool;
private _planePool = JTC_enemyPlanes call JTC_fnc_generateVehiclePool;
private _uavPool = JTC_enemyUavs call JTC_fnc_generateVehiclePool;
_groundParking = _groundParking call JTC_fnc_arrayShuffle;
_groundParking resize (count _groundVehiclePool);
_heliParking = _heliParking call JTC_fnc_arrayShuffle;
_heliParking resize (count _heliPool);
_planeParking = _planeParking call JTC_fnc_arrayShuffle;
_planeParking resize (count _planePool);
_uavParking = _uavParking call JTC_fnc_arrayShuffle;
_uavParking resize (count _uavPool);
{
    private _base = _x;
    {
        private _marker = _x;
        if ((markerPos _marker) inArea (_base select 0)) then {
            private _vehicleData = (_groundVehiclePool deleteAt 0);
            _vehicleData pushBack _marker;
            (_base select 2) pushBack _vehicleData;
        };
    } forEach _groundParking;
    {
        private _marker = _x;
        if ((markerPos _marker) inArea (_base select 0)) then {
            private _vehicleData = (_heliPool deleteAt 0);
            _vehicleData pushBack _marker;
            (_base select 2) pushBack _vehicleData;
        };
    } forEach _heliParking;
    {
        private _marker = _x;
        if ((markerPos _marker) inArea (_base select 0)) then {
            private _vehicleData = (_planePool deleteAt 0);
            _vehicleData pushBack _marker;
            (_base select 2) pushBack _vehicleData;
        };
    } forEach _planeParking;
    {
        private _marker = _x;
        if ((markerPos _marker) inArea (_base select 0)) then {
            private _vehicleData = (_uavPool deleteAt 0);
            _vehicleData pushBack _marker;
            (_base select 2) pushBack _vehicleData;
        };
    } forEach _uavParking;
} forEach _enemyBases;
private _actualBasePopulation = 0;
{
    private _area = _x select 1;
    private _basePopulation = floor (_topBasePopulation * _area / _totalBaseArea);
    private _baseVehicles = _x select 2;
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
        _x pushBack _baseVehicles;
    };
} forEach _enemyBases;
private _logBases = [];
private _totalEnemies = 0;
private _totalVehicles = 0;
{
    _logBases pushBack [_x select 0, _x select 1, count (_x select 4)];
    _totalEnemies = _totalEnemies + (_x select 1);
    _totalVehicles = _totalVehicles + count (_x select 4);
} forEach _enemyBases;
["bases: %1, %2", count _logBases, _logBases] call JTC_fnc_log;
["total enemies: %1, total enemy vehicles: %2", _totalEnemies, _totalVehicles] call JTC_fnc_log;
JTC_enemyBases = _enemyBases;
JTC_freeEnemyPopulation = JTC_enemyPopulation - _actualBasePopulation;