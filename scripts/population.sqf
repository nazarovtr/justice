JTC_enemySide = independent;
JTC_enemyFaction = "OPF_F";
JTC_civilianFaction = "CIV_F";
private _config = configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry";
JTC_enemySquads = [
    [_config >> "OI_reconTeam", 6],
    [_config >> "OI_reconPatrol", 4],
    [_config >> "OI_reconSentry", 2],
    [_config >> "OI_SniperTeam", 2],
    [_config >> "OIA_InfAssault", 8],
    [_config >> "OIA_InfTeam", 4],
    [_config >> "OIA_InfTeam_AA", 4],
    [_config >> "OIA_ReconSquad", 8],
    [_config >> "OIA_InfSquad", 8],
    [_config >> "OIA_InfSquad_Weapons", 8],
    [_config >> "OIA_InfSentry", 2]
];

JTC_enemyInfantryUnits = [
    ["O_Sharpshooter_F"],
    ["O_recon_JTAC_F"],
    ["O_Pathfinder_F"]
];

JTC_enemyVehicles = [
    ["O_Quadbike_01_F", 20, 8000, false, false],
    ["O_MRAP_02_F ", 10, 300000, false, false],
    ["O_MRAP_02_hmg_F", 10, 380000, false, true],
    ["O_MRAP_02_gmg_F", 10, 380000, false, true],
    ["O_Truck_02_covered_F", 10, 50000, true, false],
    ["O_Truck_03_covered_F", 10, 100000, true, false],
    ["O_Truck_02_transport_F", 10, 50000, true, false],
    ["O_Truck_03_transport_F", 10, 50000, true, false],
    ["O_Truck_02_ammo_F", 5, 80000, false, false],
    ["O_Truck_03_ammo_F", 5, 160000, false, false],
    ["O_Truck_02_box_F", 5, 70000, false, false],
    ["O_Truck_03_repair_F", 5, 140000, false, false],
    ["O_Truck_02_medical_F", 5, 60000, true, false],
    ["O_Truck_03_medical_F", 5, 120000, true, false],
    ["O_Truck_02_fuel_F", 5, 60000, false, false],
    ["O_Truck_03_fuel_F", 5, 120000, false, false],
    ["O_APC_Tracked_02_cannon_F", 5, 5000000, false, true],
    ["O_APC_Tracked_02_AA_F", 6, 5000000, false, true],
    ["O_MBT_02_cannon_F", 8, 6000000, false, true],
    ["O_MBT_02_arty_F", 3, 6000000, false, true],
    ["O_APC_Wheeled_02_rcws_F", 10, 3000000, true, true]
];

JTC_enemySmallestSquadSize = 2;

JTC_civilianUnits = ["C_man_1", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F",
     "C_man_polo_6_F", "C_man_p_fugitive_F", "C_man_w_worker_F", "C_man_hunter_1_F"];

JTC_civilianVehicles = [["C_Hatchback_01_F", 10], ["C_Offroad_01_F", 6], ["C_Offroad_02_unarmed_F", 6],
 ["C_Van_01_box_F", 4], ["C_Quadbike_01_F", 3], ["C_Van_01_transport_F", 3], ["C_Truck_02_covered_F", 2],
 ["C_Truck_02_transport_F", 2], ["C_SUV_01_F", 2], ["C_Hatchback_01_sport_F", 1], ["C_Offroad_01_repair_F", 1],
  ["C_Truck_02_box_F", 1], ["C_Truck_02_fuel_F", 1], ["C_Van_01_fuel_F", 1], ["C_Kart_01_F", 0.5]];
JTC_civilianRepairVehicles = ["C_Offroad_01_repair_F", "C_Truck_02_box_F"];
JTC_civilianFuelVehicles = ["C_Truck_02_fuel_F", "C_Van_01_fuel_F"];

JTC_civilianUniforms = ["U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_stripped",
"U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Commoner1_1",
"U_C_Commoner1_2","U_C_Commoner1_3", "U_Rangemaster", "U_Competitor", "U_NikosBody", "U_C_Poor_1", "U_C_Poor_2",
"U_C_WorkerCoveralls", "U_C_Poor_shorts_1", "U_C_Commoner_shorts", "U_C_ShirtSurfer_shorts",
 "U_C_TeeSurfer_shorts_1", "U_C_TeeSurfer_shorts_2", "U_OrestesBody"];
// TODO undercover enemy
JTC_enemyUniforms = [];
JTC_enemyVests = [];
JTC_helmets = [];
private _helmetConfig = "((getText ( _x >> ""displayName"" )) find ""Helmet"" > 0) && ((getText ( _x >> ""displayName"" )) find ""Racing"" < 0) && ((getText ( _x >> ""descriptionShort"" )) find ""Armor Level"" >= 0)"
    configClasses ( configFile >> "cfgWeapons");
{
    JTC_helmets pushBack (configName _x);
} forEach _helmetConfig;