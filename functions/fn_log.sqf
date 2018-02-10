private _message = format _this;
if (JTC_log) then {
    _message remoteExec ["systemChat"];
};
_message remoteExec ["diag_log"];