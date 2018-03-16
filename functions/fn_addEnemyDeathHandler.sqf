private _group = _this;
if (!isNull _group) then {
    {
        _x addEventHandler ["killed", {
            private _unit = _this select 0;
            _this call JTC_fnc_defaultEnemyDeathHandler;
            private _baseNumber = (_unit getVariable "_data") select 0;
            private _base = JTC_enemyBases select _baseNumber;
            _base set [1, (_base select 1) - 1];
            if (_base select 3 == "ok" and (1.0 * (_base select 1) / (_base select 2)) < 0.3) then {
                _base set [3, "abandoned"];
                JTC_abandonInProgressBases pushBackUnique _baseNumber;
                JTC_alarmedBases deleteAt (JTC_alarmedBases find _baseNumber);
                JTC_supportedBases deleteAt (JTC_supportedBases find _baseNumber);
                [(_base select 2) / 2, -(_base select 2) / 2] call JTC_fnc_changeRating;
                private _baseMarker = _base select 0;
                private _marker = createMarker ["cross_" + _baseMarker, getMarkerPos _baseMarker];
                _marker setMarkerType "hd_objective";
                ["patrols"] call JTC_fnc_escalate;
                ["counterattacks"] call JTC_fnc_escalate;
            };
            publicVariable "JTC_enemyBases";
            ["Unit killed on base number %1. Population: %2", _baseNumber, JTC_enemyPopulation] call JTC_fnc_log;
        }];
    } forEach units _group;
};