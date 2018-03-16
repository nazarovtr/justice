// param - array of spawned enemy arrays
{
    private _data = _x;
    private _group = _data select 1;
    private _vehicle = _data select 2;
    if (!isNull _group) then {
        {
            _x setVariable ["_data", _data, true];
        } forEach units _group;
        _group setVariable ["_data", _data, true];
    };
    if (!isNull _vehicle) then {
        _vehicle setVariable ["_data", _data, true];
    }
} forEach _this;