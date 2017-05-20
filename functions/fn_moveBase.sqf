systemChat "moving base";

theBase setPos defaultBasePos;
theLamp setPos [(defaultBasePos select 0) -1, defaultBasePos select 1, defaultBasePos select 2 ];
deployBaseActionId = player addAction ["deploy base here", "[getPos player] call JTC_fnc_deployBase;"];
