private _baseNumber = _this select 0;
private _base = JTC_enemyBases select _baseNumber;
private _markerName = _base select 0;
private _population = _base select 1;
private _status = _base select 3;
private _vehicleTypes = _base select 4;

private _spawnedEnemies = [];
// creating units

private  _spawnedMarkers = [];
private _populationLeft = _population;
{
    if (_baseNumber == (_x select 0)) then {
        _spawnedMarkers pushBackUnique (_x select 3);
        if (! isNull (_x select 1)) then {
            _populationLeft = _populationLeft - count units (_x select 1);
        };
    };
} forEach JTC_spawnedEnemies;

private _availableSquads = [];
if (_status == "ok") then {
    {
        private _parkingMarker = _x select 5;
        if ((_spawnedMarkers find _parkingMarker) < 0) then {
            private _vehiclePosition = markerPos _parkingMarker;
            private _vehicleDirection = markerDir _parkingMarker;
            private _vehicle = (_x select 0) createVehicle (getMarkerPos "safe_spawn");
            if ((typeOf _vehicle) find "Ammo" > 0 or (typeOf _vehicle) find "ammo" > 0) then {
                _vehicle call JTC_fnc_loadAmmoTruckWithMagazines;
            };
            _vehicle setDir _vehicleDirection;
            _vehicle setPos _vehiclePosition;
            if ((_x select 4) and _populationLeft > 4) then {
                createVehicleCrew _vehicle;
                private _group = group ((crew _vehicle) select 0);
                _group addVehicle _vehicle;
                _populationLeft = _populationLeft - count units _group;
                private _spawnedEntity = [_baseNumber, _group, _vehicle, _parkingMarker, JTC_goal_guard, _baseNumber];
                JTC_spawnedEnemies pushBack _spawnedEntity;
                _spawnedEnemies pushBack _spawnedEntity;
            } else {
                private _spawnedEntity = [_baseNumber, grpNull, _vehicle, _parkingMarker, JTC_goal_parked, _baseNumber];
                JTC_spawnedEnemies pushBack _spawnedEntity;
                _spawnedEnemies pushBack _spawnedEntity;
            };
        };
    } forEach _vehicleTypes;
    for "_i" from 0 to (count JTC_enemySquads) - 1 do {
        _availableSquads pushBack _i;
    };
    while {_populationLeft > 0} do {
        if (_populationLeft >= JTC_enemySmallestSquadSize) then {
            private _squadNumber = selectRandom _availableSquads;
            private _squad = JTC_enemySquads select _squadNumber;
            if ((_squad select 1) <= _populationLeft) then {
                private _group = [_markerName call BIS_fnc_randomPosTrigger, JTC_enemySide, _squad select 0] call BIS_fnc_spawnGroup;
                private _spawnedEntity = [_baseNumber, _group, objNull, "", JTC_goal_guard, _baseNumber];
                JTC_spawnedEnemies pushBack _spawnedEntity;
                _spawnedEnemies pushBack _spawnedEntity;
                _populationLeft = _populationLeft - (_squad select 1);
            } else {
                _availableSquads = _availableSquads - [_squadNumber];
            };
        } else {
            private _group = createGroup JTC_enemySide;
            _group createUnit [(selectRandom JTC_enemyInfantryUnits) select 0, _markerName call BIS_fnc_randomPosTrigger, [], 0, "NONE"];
            private _spawnedEntity = [_baseNumber, _group, objNull, "", JTC_goal_guard, _baseNumber];
            JTC_spawnedEnemies pushBack _spawnedEntity;
            _spawnedEnemies pushBack _spawnedEntity;
            _populationLeft = _populationLeft - 1;
        };
    };
};
_spawnedEnemies call JTC_fnc_setEntityDataVariables;

// ACE item adding
if (JTC_ace) then {
    {
        if (!isNull (_x select 1)) then {
            {
                if (JTC_enemyLongRangeUnits find (typeOf _x) >= 0) then {
                    _x addItemToVest "ACE_RangeCard";
                    if (random 1 > 0.2) then {
                        _x addItemToVest "ACE_Kestrel4500";
                    }
                };
            } forEach units (_x select 1);
        };
    } forEach _spawnedEnemies;
};

//creating waypoints
{
    private _group = _x select 1;
    if (!isNull _group) then {
        if (!((vehicle leader _group) isKindOf "Air")) then {
            if ((random 1) > 0.4 and ((vehicle leader _group) == (leader _group))) then {
                private _firstWaypoint = _group addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
                _group addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
                _group addWaypoint [_markerName call BIS_fnc_randomPosTrigger, 0];
                private _lastWaypoint = _group addWaypoint [getPos leader _group, 0];
                _firstWaypoint setWaypointBehaviour "SAFE";
                _lastWaypoint setWaypointType "CYCLE";
            } else {
                private _waypoint = _group addWaypoint [getPos leader _group, 0];
                _waypoint setWaypointType "HOLD";
                _waypoint setWaypointBehaviour "SAFE";
                {
                    _x spawn {
                        sleep 10;
                        _this action ["SitDown", _this];
                    }
                } forEach units _group;
            };
        };
    };
} forEach _spawnedEnemies;

// group eventhandling
{
    private _group = _x select 1;
    if (!isNull _group) then {
        _group call JTC_fnc_addEnemyDeathHandler;
        {
            _x addEventHandler ["Hit", {
                (_this select 0) call JTC_fnc_alarmBase;
            }];
            _x addEventHandler ["FiredMan", {
                (_this select 0) call JTC_fnc_alarmBase;
            }];
        } forEach units _group;
    };
} forEach _spawnedEnemies;

// vehicle event handling
{
    private _vehicle = _x select 2;
    if (!isNull _vehicle) then {
        _vehicle call JTC_fnc_addEnemyVehicleDescructionHandler;
        _vehicle addEventHandler ["Hit", {
            (_this select 0) call JTC_fnc_alarmBase;
        }];
    };
} forEach _spawnedEnemies;

["Spawned %1 on %2 population %3", _spawnedEnemies, _markerName, _population] call JTC_fnc_log;
