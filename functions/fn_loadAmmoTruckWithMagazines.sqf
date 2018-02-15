private _truck = _this;
{
    if ((random 1) < (_x select 1)) then {
        _truck addMagazineCargoGlobal [_x select 0, (_x select 2) + floor (random ((_x select 3) - (_x select 2)))];
    };
} forEach JTC_ammoTruckMagazines;