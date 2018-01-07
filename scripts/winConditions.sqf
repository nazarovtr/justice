waitUntil {
    sleep 1;
    !isNil("JTC_enemyBases");
};

while {true} do {
    if (JTC_enemyReputation < -500) then {
        if (JTC_playerReputation > 200) then {
            "governmentLostPopularityGuerillaHeroes" call BIS_fnc_endMissionServer;
        } else {
            if (JTC_playerReputation < -200) then {
                "governmentLostPopularityGuerillaCriminals" call BIS_fnc_endMissionServer;
            } else {
                "governmentLostPopularity" call BIS_fnc_endMissionServer;
            }
        }
    };
    private _okBaseCount = 0;
    for "_baseNumber" from 0 to (count JTC_enemyBases) - 1 do {
        if (((JTC_enemyBases select _baseNumber) select 3) == "ok") then {
            _okBaseCount = _okBaseCount + 1;
        };
    };
    if ((1.0 * _okBaseCount / count JTC_enemyBases) < 0.1) then {
        "basesDestroyed" call BIS_fnc_endMissionServer;
    };
    sleep 30;
};