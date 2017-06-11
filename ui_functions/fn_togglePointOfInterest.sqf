private _position = _this select 0;
systemChat format ["point in position %1", _position];
if (!isNil "JTC_commanderId") then {
    if ((getPlayerUID player) == JTC_commanderId) then {
        private _existingPoint = "";
        systemChat "commander checked";
        scopeName "main";
        {
            if (_position distance (getMarkerPos _x) < JTC_spawnDistance) then {
                _existingPoint = _x;
                breakTo "main";
            };
        } forEach JTC_pointsOfInterest;
        if (_existingPoint != "") then {
            systemChat format ["existing point %1", _existingPoint];
            JTC_pointsOfInterest = JTC_pointsOfInterest - [_existingPoint];
            deleteMarker _existingPoint;
            publicVariable "JTC_pointsOfInterest";
        } else {
            private _newPoint = "pointOfInterest_" + str JTC_pointOfInterestNumber;
            systemChat format ["new point %1", _newPoint];
            JTC_pointOfInterestNumber = JTC_pointOfInterestNumber + 1;
            JTC_pointsOfInterest pushBack _newPoint;
            publicVariable "JTC_pointsOfInterest";
            publicVariable "JTC_pointOfInterestNumber";
            private _marker = createMarker [_newPoint, _position];
            _marker setMarkerShape "ELLIPSE";
            _marker setMarkerSize [JTC_spawnDistance, JTC_spawnDistance];
            _marker setMarkerAlpha 0.4;
        };
    };
};