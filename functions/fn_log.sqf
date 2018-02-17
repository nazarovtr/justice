private _message = format _this;
private _playerName = if (isNull player) then {
    "server";
} else {
    if (isServer) then {
        "server " +(name player);
    } else {
        name player;
    }
};
_message = format ["%1: %2", _playerName, _message];
if (JTC_log) then {
    _message remoteExec ["systemChat"];
};
_message remoteExec ["diag_log"];