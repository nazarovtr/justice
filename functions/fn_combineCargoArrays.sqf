// This function is needed to get unique item numbers. In case of number collisions there is a chance of cargo loss in
// moveCargo function.
private _cargoItemNumber = 0;
private _result = [];
{
    {
        _x set [1, _cargoItemNumber];
        _result pushBack _x;
    } forEach _x;
} forEach _this;
_result;