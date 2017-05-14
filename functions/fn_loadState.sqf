systemChat "loading state";
private _saveName = ctrlText 1400;

if (count _saveName == 0) then
{
    hint "Select a Save";
}
else
{
    private _position = profileNamespace getVariable ("JTC_" + _saveName + "_basePos");
    private _direction = profileNamespace getVariable ("JTC_" + _saveName + "_baseDir");
    theOffroad setPos [_position select 0, _position select 1, (_position select 2) + 1000];
    theOffroad setDir _direction;
    theOffroad setVehiclePosition [_position, [], 10];
    theCommander moveInDriver theOffroad;
    JTC_commander = player;
    publicVariable "JTC_commander";
    closeDialog 23001;
};