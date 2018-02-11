private _playerReputationChange = _this select 0;
private _enemyReputationChange = _this select 1;

private _newEnemyRating = JTC_enemyRating;
private _newEnemyAntirating = JTC_enemyAntirating;

private _newPlayerRating = JTC_playerRating;
private _newPlayerAntirating = JTC_playerAntirating;

if (_enemyReputationChange < 0) then {
    _newEnemyRating = JTC_enemyRating * (100 + _enemyReputationChange) / 100;
    _newEnemyAntirating = JTC_enemyAntirating - (100 - JTC_enemyRating - JTC_enemyAntirating) * _enemyReputationChange / 100;
} else {
    _newEnemyAntirating = JTC_enemyAntirating * (100 - _enemyReputationChange) / 100;
    _newEnemyRating = JTC_enemyRating + (100 - JTC_enemyRating - (JTC_enemyAntirating max JTC_playerRating)) * _enemyReputationChange / 100;
};

if (_playerReputationChange < 0) then {
    _newPlayerRating = JTC_playerRating * (100 + _playerReputationChange) / 100;
    _newPlayerAntirating = JTC_playerAntirating - (100 - JTC_playerRating - JTC_playerAntirating) * _playerReputationChange / 100;
} else {
    _newPlayerAntirating = JTC_playerAntirating * (100 - _playerReputationChange) / 100;
    _newPlayerRating = JTC_playerRating + (100 - JTC_playerRating - (JTC_playerAntirating max JTC_enemyRating)) * _playerReputationChange / 100;
};

if (_newPlayerRating > 100 - _newEnemyRating) then {
    _newPlayerRating = (_newPlayerRating + (100 - _newEnemyRating)) / 2;
    _newEnemyRating = 100 - _newPlayerRating;
};
JTC_playerRating = _newPlayerRating;
JTC_playerAntirating = _newPlayerAntirating;
JTC_enemyRating = _newEnemyRating;
JTC_enemyAntirating = _newEnemyAntirating;

publicVariable "JTC_playerRating";
publicVariable "JTC_playerAntirating";
publicVariable "JTC_enemyRating";
publicVariable "JTC_enemyAntirating";
