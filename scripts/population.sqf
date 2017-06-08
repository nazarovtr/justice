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

JTC_civilianUnits = ["C_man_1", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F",
     "C_man_polo_6_F", "C_man_p_fugitive_F", "C_man_w_worker_F", "C_man_hunter_1_F"];

JTC_civilianVehicles = [["C_Hatchback_01_F", 10], ["C_Offroad_01_F", 6], ["C_Offroad_02_unarmed_F", 6],
 ["C_Van_01_box_F", 4], ["C_Quadbike_01_F", 3], ["C_Van_01_transport_F", 3], ["C_Truck_02_covered_F", 2],
 ["C_Truck_02_transport_F", 2], ["C_SUV_01_F", 2], ["C_Hatchback_01_sport_F", 1], ["C_Offroad_01_repair_F", 1],
  ["C_Truck_02_box_F", 1], ["C_Truck_02_fuel_F", 1], ["C_Van_01_fuel_F", 1], ["C_Kart_01_F", 0.5]];
JTC_civilianRepairVehicles = ["C_Offroad_01_repair_F", "C_Truck_02_box_F"];
JTC_civilianFuelVehicles = ["C_Truck_02_fuel_F", "C_Van_01_fuel_F"];