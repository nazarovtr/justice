JTC_cheats = false;
JTC_log = false;
JTC_ace = "ACE_RangeCard" isKindOf ["ACE_ItemCore", configFile >> "CfgWeapons"];
JTC_defaultPlayerRating = 2;
JTC_defaultPlayerAntirating = 0;
JTC_defaultEnemyRating = 71;
JTC_defaultEnemyAntirating = 12;
JTC_civilianPopulation = 6000;
JTC_recruitablePopulation = 800;
JTC_civilianSpawnPercent = 10;
JTC_enemyPopulation = 900;
JTC_baseRadius = 100;
JTC_money = 10000;
JTC_recruitCount = 25;
JTC_spawnDistance = paramsArray select 2;
JTC_mapLandArea = 270000000;
JTC_maxPatrolSize = 6;
JTC_pointsOfInterest = [];
JTC_pointOfInterestNumber = 0;
JTC_ignoredAssignedItems = ["ItemMap", "ItemCompass", "ItemWatch", "ItemRadio"];
if (!isNil("startingQuad1")) then {
    JTC_startingVehicles = [startingQuad1, startingOffroad1, startingOffroad2, startingOffroad3, startingSuv1,
     startingSport1, startingTruck1, startingTruck2, startingTruck3, startingKart1];
};
JTC_respawnMarker = "respawn_west";
JTC_hqMarkerType = "b_hq";
JTC_escalation = [];
tawvd_disablenone = true;
tawvd_maxRange = 12000;