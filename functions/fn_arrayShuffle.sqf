// shuffles better than BIS_fnc_arrayShuffle but may be slower;
private _array = +_this;

private _result = [];
for "_i" from 1 to (count _array) do {
    _result pushBack (_array deleteAt (floor random (count _array)))
};
_result;