part of '../main.dart';

extension GameFunctionsInternal on Application {
  ClearFocus() {
    _focusStatus = [];
    for (int i = 0; i < _nrPlayers; i++) {
      _focusStatus.add(List.filled(_totalFields, 0));
    }
  }

  CellClick(int player, int cell) {
    if (player == _playerToMove &&
        _myPlayerId == _playerToMove &&
        !_fixedCell[player][cell] &&
        _cellValue[player][cell] != -1) {
      net.SendSelection(player, cell, _dices._diceValue);
      CalcNewSums(player, cell);
    }
  }

  CalcNewSums(int player, int cell) {
    if (_dices._unityDices[0]) {
      _dices.SendResetToUnity();
    }

    _colors[_playerToMove + 1][cell] = Colors.green.withOpacity(0.7);
    _fixedCell[_playerToMove][cell] = true;
    // Update Sums
    var sum = 0;
    int totalSum = 0;
    var ts = 0;
    for (int i = 0; i < 6; i++) {
      if (_fixedCell[_playerToMove][i]) {
        ts++;
        sum += _cellValue[_playerToMove][i] as int;
      }
    }
    totalSum = sum;
    _text[_playerToMove + 1][6] = sum.toString();
    if (sum >= _bonusSum) {
      _text[_playerToMove + 1][7] = _bonusAmount.toString();
      totalSum += _bonusAmount;
    } else {
      if (ts != 6) {
        _text[_playerToMove + 1][7] = (sum - _bonusSum).toString();
      } else {
        _text[_playerToMove + 1][7] = "0";
      }
    }
    for (int i = 8; i <= _totalFields - 2; i++) {
      if (_fixedCell[_playerToMove][i]) {
        totalSum += _cellValue[_playerToMove][i] as int;
      }
    }
    _text[_playerToMove + 1][_totalFields - 1] = totalSum.toString();
    _cellValue[_playerToMove][_totalFields - 1] = totalSum;

    // New Rolls
    for (int i = 0; i < _totalFields; i++) {
      if (!_fixedCell[_playerToMove][i]) {
        _text[_playerToMove + 1][i] = "";
        _cellValue[_playerToMove][i] = -1;
      }
    }

    ClearFocus();
    _playerToMove = (_playerToMove + 1) % _nrPlayers;
    if (!_fixedCell[_playerToMove].contains(false)) {
      // Game finished
      for (int i = 0; i < _nrPlayers; i++) {
        print(_cellValue);
        highscore.Update(userName, _cellValue[i][_totalFields - 1]);
      }
    }

    for (int i = 0; i < _totalFields; i++) {
      if (_fixedCell[_playerToMove][i]) {
        _colors[0][i] = Colors.white.withOpacity(0.7);
      } else {
        _colors[0][i] = Colors.white.withOpacity(0.3);
      }
    }
    for (int i = 0; i < _nrPlayers; i++) {
      for (int j = 0; j < _totalFields; j++) {
        if (!_fixedCell[i][j]) {
          if (i == _playerToMove) {
            _colors[i + 1][j] = Colors.greenAccent.withOpacity(0.3);
          } else {
            _colors[i + 1][j] = Colors.grey.withOpacity(0.3);
          }
        }
      }
    }
    _dices.ClearDices();
    animationBoardEffect.AnimateBoard();
    if (_playerToMove == _myPlayerId) {
      _dices.StartDices();
    }
  }
}
