private _target = _this select 0;
private _text = _this select 1;
[_target, [_text, "[_this select 0] call JTC_fnc_stealUniform;", [], 0, false, true, "",
     "(uniform _target) != ''", 3]] remoteExec ["addAction", 0, _target];