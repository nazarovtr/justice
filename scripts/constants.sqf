JTC_enemySide = independent;
JTC_enemyFaction = "IND_F";
JTC_civilianFaction = "CIV_F";
JTC_baseRadius = 100;
JTC_ignoredAssignedItems = ["ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"];
JTC_startingVehicles = [startingQuad1, startingOffroad1, startingSport1, startingTruck1, startingTruck2, startingKart1];
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
