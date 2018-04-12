waitUntil {
    sleep 1;
    !isNil("JTC_missionStarted");
};

while {true} do {
    if (JTC_enemyAntirating > 50) then {
        if (JTC_playerRating > 30 and JTC_playerAntirating < 15) then {
            "governmentLostPopularityGuerillaHeroes" call BIS_fnc_endMissionServer;
        } else {
            if (JTC_playerAntirating > 25) then {
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