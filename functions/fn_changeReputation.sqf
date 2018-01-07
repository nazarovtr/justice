private _playerReputationChange = _this select 0;
private _enemyReputationChange = _this select 1;

private _playerReputation = JTC_playerReputation + _playerReputationChange;
private _enemyReputation = JTC_enemyReputation + _enemyReputationChange;

if (_playerReputation < -1000) then {
    JTC_playerReputation = -1000;
} else {
    if (_playerReputation > 1000) then {
        JTC_playerReputation = 1000;
    } else {
        JTC_playerReputation = _playerReputation;
    };
};

if (_enemyReputation < -1000) then {
    JTC_enemyReputation = -1000;
} else {
   if (_enemyReputation > 1000) then {
       JTC_enemyReputation = 1000;
   } else {
       JTC_enemyReputation = _enemyReputation;
   };
};

publicVariable "JTC_playerReputation";
publicVariable "JTC_enemyReputation";
