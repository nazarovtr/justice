private _men = nearestObjects [player, ["Man"], 10];
{
    if (side _x != side player) then {
        _x setDamage 1;
    };
} forEach _men;