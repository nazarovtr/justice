private _container = _this select 0;
private _items = +(_this select 1);
private _initialCargo = [_container] call JTC_fnc_getContainerCargo;
private _resultingCargo = [];
{
    private _item = _x select 0;
    private _remove = false;
    scopeName "cargoIter";
    {
        if ((_x select 0) == _item && (_x select 1) > 0) then {
            _x set [1, (_x select 1) - 1];
            _remove = true;
            breakTo "cargoIter";
        }
    } forEach _items;
    if (!_remove) then {
        _resultingCargo pushBack _x;
    }
} forEach _initialCargo;
[_container, _resultingCargo] call JTC_fnc_setContainerCargo;
