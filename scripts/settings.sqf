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
