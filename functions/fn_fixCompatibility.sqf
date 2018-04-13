private _fixOneItemIfNeeded = {
    private _key = _this select 0;
    private _fixFunction = _this select 1;
    if ((JTC_compatibility find _key) < 0) then {
        call _fixFunction;
        JTC_compatibility pushBackUnique _key;
        ["Compatibility fixed: %1", _key] call JTC_fnc_log;
    } else {
        ["Already compatible: %1", _key] call JTC_fnc_log;
    };
};

[JTC_comp_patrolsAndCounterattacks, {
    scopeName "main";
    {
        if ((_x select 3) == "abandoned") then {
            ["patrols"] call JTC_fnc_escalate;
            ["counterattacks"] call JTC_fnc_escalate;
            breakTo "main";
        };
    } forEach JTC_enemyBases;
}] call _fixOneItemIfNeeded;

[JTC_comp_smallerRepLoss, {
    [10, 0] call JTC_fnc_changeRating;
    JTC_playerAntirating = JTC_playerAntirating / 2;
}] call _fixOneItemIfNeeded;

[JTC_comp_tanksDlc, {
    private _angaraCount = 0;
    private _angaraCommandCount = 0;
    private _angaraPool = [];
    {
        if ((_x select 0) == "O_MBT_04_cannon_F") then {
            _angaraCount = _x select 1;
            for "_i" from 1 to _angaraCount do {
                _angaraPool pushBack (+_x);
            };
        };
        if ((_x select 0) == "O_MBT_04_command_F") then {
            _angaraCommandCount = _x select 1;
            for "_i" from 1 to _angaraCommandCount do {
                _angaraPool pushBack (+_x);
            };
        };
    } forEach JTC_enemyGroundVehicles;
    scopeName "main";
    {
        {
            if ((count _angaraPool) == 0) then {
                breakTo "main";
            };
            if ((_x select 0) == "O_MBT_02_cannon_F") then {
                private _angaraData = _angaraPool deleteAt 0;
                for "_i" from 0 to (count _angaraData) - 1 do {
                    _x set [_i, _angaraData select _i];
                };
            }
        } forEach (_x select 4);
    } forEach JTC_enemyBases;
    publicVariable "JTC_enemyBases";
}] call _fixOneItemIfNeeded;