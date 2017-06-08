// Most effective when input is sorted by weight in descending order.
private _weightedItems = _this;
private _totalWeight = 0;
{
    _totalWeight = _totalWeight + (_x select 1);
} forEach _weightedItems;
private _randomNumber = random _totalWeight;

private _value = objNull;
private _currentWeight = 0;
scopeName "main";
{
    _currentWeight = _currentWeight + (_x select 1);
    if (_randomNumber < _currentWeight) then {
        _value = _x select 0;
        breakTo "main";
    }
} forEach _weightedItems;
_value;