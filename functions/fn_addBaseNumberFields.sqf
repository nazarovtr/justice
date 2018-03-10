// param - array of spawned enemy arrays
{
    private _baseNumber = _x select 0;
    private _group = _x select 1;
    private _vehicle = _x select 2;
    if (!isNull _group) then {
        {
            _x setVariable ["_baseNumber", _baseNumber, true];
        } forEach units _group;
        _group setVariable ["_baseNumber", _baseNumber, true];
    };
    if (!isNull _vehicle) then {
        _vehicle setVariable ["_baseNumber", _baseNumber, true];
    }
} forEach _this;