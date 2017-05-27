JTC_enemySide = independent;
private _config = configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry";
JTC_enemySquads = [
    [_config >> "HAF_InfSquad", 8],
    [_config >> "HAF_InfSquad_Weapons", 8],
    [_config >> "HAF_InfTeam_AA", 4],
    [_config >> "HAF_InfTeam_AT", 4],
    [_config >> "HAF_SniperTeam", 2],
    [_config >> "HAF_InfSentry", 2]
];

JTC_enemyInfantryUnits = [
    ["I_Soldier_M_F"]
];

JTC_enemySmallestSquadSize = 8;
{
    if ((_x select 1) <  JTC_enemySmallestSquadSize) then {
        JTC_enemySmallestSquadSize = _x select 1;
    };
} forEach JTC_enemySquads;