waitUntil {
    sleep 1;
    !isNil("JTC_cities");
};

JTC_spawnedCities = [];
{
    JTC_spawnedCities pushBack false;
} forEach JTC_cities;

JTC_spawnedInfrastructure = [];
{
    JTC_spawnedInfrastructure pushBack false;
} forEach JTC_civilianInfrastructure;

while {true} do {
    for "_cityNumber" from 0 to (count JTC_cities) - 1 do {
        private _city = JTC_cities select _cityNumber;
        if (!(JTC_spawnedCities select _cityNumber) &&
         [getMarkerPos (_city select 0)] call JTC_fnc_isInSpawnArea) then {
            [_city select 0, _cityNumber, _city select 1] call JTC_fnc_populateCity;
        };
    };
    for "_infraNumber" from 0 to (count JTC_civilianInfrastructure) - 1 do {
        private _infra = JTC_civilianInfrastructure select _infraNumber;
        if (!(JTC_spawnedInfrastructure select _infraNumber) &&
         [getMarkerPos (_infra select 0)] call JTC_fnc_isInSpawnArea) then {
            [_infraNumber] call JTC_fnc_populateCivilianInfrastructure;
        };
    };
    sleep 5;
};