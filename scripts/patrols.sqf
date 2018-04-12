private _patrolGroups = [];
private _patrolSquads = [];
private _debugMarkers = [];
{
    if ((_x select 1) <= JTC_maxPatrolSize) then {
        _patrolSquads pushBack (_x select 0);
    };
} forEach JTC_enemySquads;

waitUntil {
    sleep 1;
    !isNil("JTC_missionStarted");
};

private _getWaypointPosition = {
    private _startPosition = _this select 0;
    private _found = false;
    private _waypointPosition = [0, 0];
    while {!_found} do {
        _waypointPosition = _startPosition getPos [200 + random 1000, random 360];
        if (!surfaceIsWater _waypointPosition) then {
            _found = true;
        };
    };
    _waypointPosition;
};

private _countGroupsAtAnchor = {
    private _anchor = _this select 0;
    private _count = 0;
    {
        if (_anchor distance2D (position leader _x) < JTC_spawnDistance) then {
            _count = _count + 1;
        };
    } forEach _patrolGroups;
    _count;
};

while {true} do {
    sleep 10;
    if ("patrols" call JTC_fnc_isEscalated) then {
        private _spawnedPatrolPopulation = 0;
        _patrolGroups = _patrolGroups select {
            private _group = _x;
            if (!([position leader _group] call JTC_fnc_isInSpawnArea)) then {
                ["Despawning patrol %1", _group] call JTC_fnc_log;
                {
                    deleteVehicle _x;
                } forEach units _group;
                deleteGroup _group;
                false;
            } else {
                _spawnedPatrolPopulation = _spawnedPatrolPopulation + count units _group;
                true;
            };
        };
        private _spawnArea = call JTC_fnc_getSpawnArea;
        private _patrolPopulation = JTC_freeEnemyPopulation * _spawnArea / JTC_mapLandArea;
        if (_patrolPopulation - _spawnedPatrolPopulation >= 1) then {
            private _spawnAreaAnchorPositions = call JTC_fnc_getSpawnAreaAnchorPositions;
            private _spawned = false;
            private _anchorAttemptsLeft = 3;
            private _maxGroupsAtAnchor = 0;
            ["Patrol population: %1", _patrolPopulation] call JTC_fnc_log;
            while {!_spawned} do {
                private _anchorCandidate = selectRandom _spawnAreaAnchorPositions;
                private _groupsAtAnchor = [_anchorCandidate] call _countGroupsAtAnchor;
                if (_groupsAtAnchor == 0 or _groupsAtAnchor < _maxGroupsAtAnchor or _anchorAttemptsLeft == 0) then {
                    private _candidateDistance = if ((0.95 * JTC_spawnDistance) > 1500) then {
                        1500 + random (0.95 * JTC_spawnDistance - 1500);
                    } else {
                        0.95 * JTC_spawnDistance;
                    };
                    private _candidatePosition = _anchorCandidate getPos [_candidateDistance, random 360];
                    ["Patrol candidate position: %1", _candidatePosition] call JTC_fnc_log;
                    if (!([_candidatePosition, (0.75 * JTC_spawnDistance) min 1350] call JTC_fnc_isInSpawnArea)) then {
                        if (!surfaceIsWater _candidatePosition) then {
                            private _group = [_candidatePosition, JTC_enemySide, selectRandom _patrolSquads] call BIS_fnc_spawnGroup;
                            ["Spawned patrol %1", _group] call JTC_fnc_log;
                            _patrolGroups pushBack _group;
                            _spawned = true;
                            _group addWaypoint [[_candidatePosition] call _getWaypointPosition, 0];
                            _group addWaypoint [[_candidatePosition] call _getWaypointPosition, 0];
                            _group addWaypoint [[_candidatePosition] call _getWaypointPosition, 0];
                            _group addWaypoint [_candidatePosition, 0];
                            [_group, 4] setWaypointType "CYCLE";
                            [_group, 1] setWaypointBehaviour "SAFE";
                            {
                                _x addEventHandler ["killed", {
                                    private _unit = _this select 0;
                                    _this call JTC_fnc_defaultEnemyDeathHandler;
                                    JTC_freeEnemyPopulation = JTC_freeEnemyPopulation - 1;
                                    publicVariable "JTC_freeEnemyPopulation";
                                    ["Patrol unit killed"] call JTC_fnc_log;
                                }];
                            } forEach units _group;
                        };
                    };
                } else {
                    _anchorAttemptsLeft = _anchorAttemptsLeft - 1;
                    _maxGroupsAtAnchor = _groupsAtAnchor;
                };
            };
        };
        if (JTC_log) then {
            {
                deleteMarker _x;
            } forEach _debugMarkers;
            _debugMarkers = [];
            {
                private _markerName = format ["Patrol %1", _x];
                createMarker [_markerName, position leader _x];
                _markerName setMarkerText _markerName;
                _markerName setMarkerShape "ICON";
                _markerName setMarkerType "hd_dot";
                _markerName setMarkerColor "ColorRed";
                _debugMarkers pushBack _markerName;
            } forEach _patrolGroups;
        };
    };
};
