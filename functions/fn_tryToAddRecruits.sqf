private _addRecruits = {
    private _count = _this;
    JTC_recruitablePopulation = JTC_recruitablePopulation - _count;
    JTC_civilianPopulation = JTC_civilianPopulation - _count;
    scopeName "main";
    {
        if ((_x select 1) > _count) then {
            _x set [1, (_x select 1) - _count];
            breakTo "main";
        };
    } forEach JTC_cities;
    JTC_recruitCount = JTC_recruitCount + _count;
    publicVariable "JTC_recruitablePopulation";
    publicVariable "JTC_civilianPopulation";
    publicVariable "JTC_cities";
    publicVariable "JTC_recruitCount";
    ["%1 rectuits added", _count] call JTC_fnc_log;
};
private _peopleWantingToJoin = round (((JTC_recruitablePopulation + JTC_recruitCount + JTC_deadRecruitCount) * JTC_playerRating / 100)
    - JTC_recruitCount - JTC_deadRecruitCount);

if (_peopleWantingToJoin > 30) then {
    3 call _addRecruits;
} else {
    if (_peopleWantingToJoin > 15) then {
        2 call _addRecruits;
    } else {
        if (_peopleWantingToJoin > 0) then {
            1 call _addRecruits;
        };
    };
};
