systemChat "weather script initialized";

// JIP
if (!isNil "JTC_overcast") then {
    0 setOvercast JTC_overcast;
    forceWeatherChange;
};

"JTC_overcast" addPublicVariableEventHandler {
    private _overcast = _this select 1;
    if (isServer) then {
        (format ["Server got network overcast %1, current is %2", _overcast, overcast]) remoteExec ["systemChat"];
    } else {
        (format ["Client got network overcast %1, current is %2", _overcast, overcast]) remoteExec ["systemChat"];
    };
    if (abs (overcast - _overcast) > 0.05) then {
        0 setOvercast _overcast;
        forceWeatherChange;
    } else {
        0 setOvercast _overcast;
    };
};

if (isServer) then {
    0 setOvercast random 1;
    forceWeatherChange;
    systemChat format ["Random overcast %1", overcast];

    if (isMultiplayer) then {
        [] spawn {
            while { true } do {
                JTC_overcast = overcast;
                publicvariable "JTC_overcast";
                sleep 20;
            };
        };
    };

    while {true} do {
        private _overcast = random 1;
        systemChat format ["Setting half hour overcast %1, current is %2", _overcast, overcast];
        1800 setOvercast _overcast;
        sleep 3600;
    };
};
