private _vehicle = _this;
if (!isNull _vehicle) then {
    _vehicle addMPEventHandler ["MPKilled", {
        if (isServer) then {
            private _vehicle = _this select 0;
            private _stolen = _vehicle getVariable "_stolen";
            if (isNil "_stolen") then {
                ["Enemy vehicle destroyed"] call JTC_fnc_log;
                private _baseNumber = _vehicle getVariable "_baseNumber";
                private _base = JTC_enemyBases select _baseNumber;
                [_vehicle, _base] call JTC_fnc_removeVehicleFromEnemyBase;
            };
        };
    }];
};
