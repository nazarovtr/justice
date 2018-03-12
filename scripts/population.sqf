JTC_enemySide = east;
JTC_playerSide = west;
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

JTC_enemyLongRangeUnits = [
    "O_Sharpshooter_F",
    "O_Pathfinder_F",
    "O_soldier_M_F",
    "O_recon_M_F",
    "O_spotter_F",
    "O_sniper_F"
];

JTC_enemyGroundVehicles = [
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

JTC_enemyHelicopters = [
    ["O_Heli_Light_02_F", 6, 6000000, false, true],
    ["O_Heli_Light_02_unarmed_F", 8, 5000000, true, false],
    ["O_Heli_Transport_04_bench_F", 6, 11000000, true, false],
    ["O_Heli_Attack_02_F", 4, 16000000, false, true]
];

JTC_enemyUavs = [
    ["O_UAV_02_F", 6, 8000000, false, false],
    ["O_UAV_02_CAS_F", 4, 8000000, false, false]
];

JTC_enemyPlanes = [
    ["O_Plane_CAS_02_F", 4, 15000000, false, false]
];

JTC_enemyArtillery = ["O_MBT_02_arty_F"];

JTC_enemySmallestSquadSize = 2;

JTC_ammoTruckMagazines = [
    ["30Rnd_65x39_caseless_green", 0.99, 8, 30],
    ["30Rnd_65x39_caseless_green_mag_Tracer", 0.99, 8, 20],
    ["150Rnd_762x54_Box", 0.5, 1, 3],
    ["150Rnd_762x54_Box_Tracer", 0.5, 1, 3],
    ["10Rnd_762x54_Mag", 0.9, 8, 20],
    ["10Rnd_93x64_DMR_05_Mag", 0.7, 5, 12],
    ["150Rnd_93x64_Mag", 0.3, 2, 3],
    ["5Rnd_127x108_Mag", 0.7, 5, 20],
    ["5Rnd_127x108_APDS_Mag", 0.6, 5, 20],
    ["RPG32_F", 0.7, 3, 12],
    ["RPG32_HE_F", 0.7, 3, 12],
    ["APERSBoundingMine_Range_Mag", 0.2, 1, 6],
    ["APERSMine_Range_Mag", 0.2, 1, 6],
    ["ClaymoreDirectionalMine_Remote_Mag", 0.3, 1, 5],
    ["DemoCharge_Remote_Mag", 0.3, 1, 3],
    ["SatchelCharge_Remote_Mag", 0.2, 1, 2],
    ["SLAMDirectionalMine_Wire_Mag", 0.2, 1, 4],
    ["MiniGrenade", 0.8, 5, 15],
    ["HandGrenade", 0.8, 5, 15],
    ["SmokeShellOrange", 0.2, 1, 4],
    ["SmokeShellRed", 0.2, 1, 4],
    ["SmokeShell", 0.2, 1, 4]
];

JTC_civilianUnits = ["C_man_1", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F",
     "C_man_polo_6_F", "C_man_p_fugitive_F", "C_man_w_worker_F", "C_man_hunter_1_F"];

JTC_civilianVehicles = [["C_Hatchback_01_F", 10], ["C_Offroad_01_F", 6], ["C_Offroad_02_unarmed_F", 6],
 ["C_Van_01_box_F", 4], ["C_Quadbike_01_F", 3], ["C_Van_01_transport_F", 3], ["C_Truck_02_covered_F", 2],
 ["C_Truck_02_transport_F", 2], ["C_SUV_01_F", 2], ["C_Hatchback_01_sport_F", 1], ["C_Offroad_01_repair_F", 1],
  ["C_Truck_02_box_F", 1], ["C_Truck_02_fuel_F", 1], ["C_Van_01_fuel_F", 1], ["C_Kart_01_F", 0.5]];
JTC_civilianRepairVehicles = ["C_Offroad_01_repair_F", "C_Truck_02_box_F"];
JTC_civilianFuelVehicles = ["C_Truck_02_fuel_F", "C_Van_01_fuel_F"];
JTC_civilianHelicopters = ["C_Heli_Light_01_civil_F"];
JTC_civilianPlanes = ["C_Plane_Civil_01_F", "C_Plane_Civil_01_racing_F"];

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