waitUntil {
    sleep 1;
    !isNil("JTC_enemyBases");
};

JTC_spawnedBases = [];
{
    JTC_spawnedBases pushBack false;
} forEach JTC_enemyBases;

while {true} do {
    for "_baseNumber" from 0 to (count JTC_enemyBases) -1 do {
        private _base = JTC_enemyBases select _baseNumber;
        if (!(JTC_spawnedBases select _baseNumber) &&
         [getMarkerPos (_base select 0)] call JTC_fnc_isInSpawnArea) then {
            [_base select 0, _baseNumber, _base select 1] call JTC_fnc_populateBase;
        };
    };
    sleep 5;
}