private _vehiclePool = [];
{
    private _increment = ((count _vehiclePool) + (_x select 1)) / (_x select 1);
    for "_i" from 0 to (_x select 1) - 1 do {
        private _insertNumber = round (_i * _increment);
        [_vehiclePool, _insertNumber, _x] call JTC_fnc_insertIntoArray;
    };
} forEach (JTC_enemyVehicles call JTC_fnc_arrayShuffle);
_vehiclePool;