private _spawnAreaAnchorPositions = [];

if (JTC_baseDeployed) then {
    _spawnAreaAnchorPositions pushBack (getPos theBase);
};

if (isMultiplayer) then {
    {
        _spawnAreaAnchorPositions pushBack getPos _x;
    } forEach playableUnits;
} else {
    _spawnAreaAnchorPositions pushBack getPos player;
};

{
    _spawnAreaAnchorPositions pushBack getMarkerPos _x;
} forEach JTC_pointsOfInterest;

_spawnAreaAnchorPositions;