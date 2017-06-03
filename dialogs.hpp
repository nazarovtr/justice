class JTC_SaveDialog
{
    idd = 23001;
    movingEnabled = false;
    class controls
    {
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT START (by Timur, v1.063, #Niquwo)
        ////////////////////////////////////////////////////////

        class JTC_SaveBackground: IGUIBack
        {
        	idc = 2200;
        	x = 0.316719 * safezoneW + safezoneX;
        	y = 0.296 * safezoneH + safezoneY;
        	w = 0.350625 * safezoneW;
        	h = 0.496 * safezoneH;
        };
        class JTC_SaveList: RscListbox
        {
        	idc = 1500;
        	x = 0.324687 * safezoneW + safezoneX;
        	y = 0.347 * safezoneH + safezoneY;
        	w = 0.151406 * safezoneW;
        	h = 0.431 * safezoneH;
        };
        class JTC_SaveListLabel: RscText
        {
        	idc = 1000;
        	text = "Saved games"; //--- ToDo: Localize;
        	x = 0.324687 * safezoneW + safezoneX;
        	y = 0.313 * safezoneH + safezoneY;
        	w = 0.111562 * safezoneW;
        	h = 0.034 * safezoneH;
        };
        class JTC_SaveSelected: RscEdit
        {
        	idc = 1400;
        	text = ""; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.347 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        };
        class JTC_SaveButton: RscButton
        {
        	idc = 1600;
        	text = "Save"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.415 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "[] call JTCUI_fnc_saveState";
        };
        class JTC_LoadButton: RscButton
        {
        	idc = 1601;
        	text = "Load"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.483 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "[] call JTCUI_fnc_loadState";
        };
        class JTC_NewButton: RscButton
        {
        	idc = 1602;
        	text = "New Game"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.551 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "[] call JTCUI_fnc_newGameState";
        };
        class JTC_SaveCancelButton: RscButton
        {
        	idc = 1603;
        	text = "Cancel"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.619 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "closeDialog 0";
        };
        class JTC_SaveNotACommanderButton: RscButton
        {
        	idc = 1604;
        	text = "I am not a commander"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.687 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "closeDialog 0";
        };
        class JTC_RemoveSaveButton: RscButton
        {
        	idc = 1605;
        	text = "Remove saved game"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.745 * safezoneH + safezoneY;
        	w = 0.175312 * safezoneW;
        	h = 0.034 * safezoneH;
        	action = "[] call JTCUI_fnc_removeSavedState";
        };
        class JTC_SelectedSaveLabel: RscText
        {
        	idc = 1001;
        	text = "Selected save"; //--- ToDo: Localize;
        	x = 0.484062 * safezoneW + safezoneX;
        	y = 0.313 * safezoneH + safezoneY;
        	w = 0.111562 * safezoneW;
        	h = 0.034 * safezoneH;
        };
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT END
        ////////////////////////////////////////////////////////

    };
};

class RscTitles
{
    class JTC_StateTitle
    {
        idd = 23002;
        duration = 2000000;
        onLoad = "with uiNameSpace do { JTC_StateTitle = _this select 0 }";
        class controls
        {
            class JTC_StateLabel: RscText
            {
                idc = 1002;
                text = "Commander: "; //--- ToDo: Localize;
                x = 0.324687 * safezoneW + safezoneX;
                y = 0.0 * safezoneH + safezoneY;
                w = 0.6 * safezoneW;
                h = 0.034 * safezoneH;
                sizeEx = 0.03;
            };
        };
    };
};