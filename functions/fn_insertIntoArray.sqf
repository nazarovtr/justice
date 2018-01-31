private _array = _this select 0;
private _number = _this select 1;
private _element = _this select 2;

if (count _array > 0) then {
    for "_j" from ((count _array) - 1) to _number step -1 do {
        _array set [_j + 1, _array select _j];
    };
};
_array set [_number, _element];