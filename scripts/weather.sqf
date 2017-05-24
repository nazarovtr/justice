systemChat "weather script initialized";

fn_getRandomOvercast = {
    private _overcast = random 1;
    _overcast = _overcast * _overcast; // Altis arid climate.
    _overcast;
};

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
    0 setOvercast ([] call fn_getRandomOvercast);
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
        private _overcast = [] call fn_getRandomOvercast;
        systemChat format ["Setting half hour overcast %1, current is %2", _overcast, overcast];
        1800 setOvercast _overcast;
        sleep 3600;
    };
};
