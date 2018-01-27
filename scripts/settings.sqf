JTC_enemySide = independent;
JTC_enemyFaction = "IND_F";
JTC_civilianFaction = "CIV_F";
JTC_cheats = true;
JTC_log = true;
JTC_defaultPlayerReputation = 0;
JTC_defaultEnemyReputation = 400;
JTC_baseRadius = 100;
JTC_money = 10000;
JTC_recruitCount = 25;
JTC_spawnDistance = 2000;
JTC_pointsOfInterest = [];
JTC_pointOfInterestNumber = 0;
JTC_ignoredAssignedItems = ["ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"];
if (!isNil("startingQuad1")) then {
    JTC_startingVehicles = [startingQuad1, startingOffroad1, startingSport1, startingTruck1, startingTruck2, startingKart1];
};
JTC_respawnMarker = "respawn_west";
JTC_hqMarkerType = "b_hq";
JTC_civilianUniforms = ["U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_stripped",
"U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Commoner1_1",
"U_C_Commoner1_2","U_C_Commoner1_3", "U_Rangemaster", "U_Competitor", "U_NikosBody", "U_C_Poor_1", "U_C_Poor_2",
"U_C_WorkerCoveralls", "U_C_Poor_shorts_1", "U_C_Commoner_shorts", "U_C_ShirtSurfer_shorts",
 "U_C_TeeSurfer_shorts_1", "U_C_TeeSurfer_shorts_2"];
JTC_enemyUniforms = ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve", "U_I_CombatUniform_tshirt",
"U_I_FullGhillie_ard", "U_I_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_I_GhillieSuit",
"U_I_OfficerUniform"];
JTC_enemyVests = ["U_I_CombatUniform", "U_I_CombatUniform_shortsleeve", "U_I_CombatUniform_tshirt",
"U_I_FullGhillie_ard", "U_I_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_I_GhillieSuit",
"U_I_OfficerUniform"];
JTC_helmets = [];
private _helmetConfig = "((getText ( _x >> ""displayName"" )) find ""Helmet"" > 0) && ((getText ( _x >> ""displayName"" )) find ""Racing"" < 0) && ((getText ( _x >> ""descriptionShort"" )) find ""Armor Level"" >= 0)"
    configClasses ( configFile >> "cfgWeapons");
{
    JTC_helmets pushBack (configName _x);
} forEach _helmetConfig;
JTC_enemyVehicles = [
    ["I_Quadbike_01_F", 20, 8000, false, false],
    ["I_MRAP_03_F", 10, 300000, false, false],
    ["I_MRAP_03_hmg_F", 10, 380000, false, true],
    ["I_MRAP_03_gmg_F", 10, 380000, false, true],
    ["I_Truck_02_covered_F", 20, 50000, true, false],
    ["I_Truck_02_transport_F", 20, 50000, true, false],
    ["I_Truck_02_ammo_F", 10, 80000, false, false],
    ["I_Truck_02_box_F", 10, 70000, false, false],
    ["I_Truck_02_medical_F", 10, 60000, true, false],
    ["I_Truck_02_fuel_F", 10, 60000, false, false],
    ["I_Truck_02_fuel_F", 10, 60000, false, false],
    ["I_APC_tracked_03_cannon_F", 10, 5000000, false, true],
    ["I_MBT_03_cannon_F", 10, 6000000, false, true],
    ["I_APC_Wheeled_03_cannon_F", 10, 3000000, true, true]
];
