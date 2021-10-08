part of '../main.dart';

extension GameCalcDiceValues on Application {
  int Zero() {
    return 0;
  }

  int Ones() {
    var eye = 1;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int Twos() {
    var eye = 2;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int Threes() {
    var eye = 3;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int Fours() {
    var eye = 4;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int Fives() {
    var eye = 5;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int Sixes() {
    var eye = 6;
    var value = 0;
    for (var i = 0; i < _dices._nrDices; i++) {
      if (_dices._diceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  List CalcDiceNr() {
    var tmp = List.filled(6, 0);
    for (var i = 0; i < _dices._nrDices; i++) {
      tmp[_dices._diceValue[i] - 1]++;
    }
    return tmp;
  }

  int Pair() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 2) {
        value = (i + 1) * 2;
        break;
      }
    }
    return value;
  }

  int TwoPairs() {
    var value = 0;
    var pairs = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 2) {
        value += (i + 1) * 2;
        pairs++;
      }
    }
    if (pairs != 2) {
      value = 0;
    }
    return value;
  }

  int ThreePairs() {
    var value = 0;
    var pairs = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 2) {
        value += (i + 1) * 2;
        pairs++;
      }
    }
    if (pairs != 3) {
      value = 0;
    }
    return value;
  }

  int ThreeOfKind() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 3) {
        value = (i + 1) * 3;
        break;
      }
    }
    return value;
  }

  int FourOfKind() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 4) {
        value = (i + 1) * 4;
        break;
      }
    }
    return value;
  }

  int FiveOfKind() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 5) {
        value = (i + 1) * 5;
        break;
      }
    }
    return value;
  }

  int Yatzy() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] == _dices._nrDices) {
        if (_dices._nrDices == 4) {
          value = 25;
        }
        if (_dices._nrDices == 5) {
          value = 50;
        }
        if (_dices._nrDices == 6) {
          value = 100;
        }
      }
    }
    return value;
  }

  int House() {
    var value = 0;
    var pair = 0;
    var triplet = 0;
    var diceNr = CalcDiceNr();

    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 3) {
        value += (i + 1) * 3;
        triplet = 1;
        diceNr[i] = 0;
        break;
      }
    }

    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 2) {
        value += (i + 1) * 2;
        pair = 1;
        break;
      }
    }
    if ((pair != 1) || (triplet != 1)) {
      value = 0;
    }
    return value;
  }

  int Tower() {
    var value = 0;
    var pair = 0;
    var triplet = 0;
    var diceNr = CalcDiceNr();

    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 4) {
        value += (i + 1) * 3;
        triplet = 1;
        diceNr[i] = 0;
        break;
      }
    }

    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] >= 2) {
        value += (i + 1) * 2;
        pair = 1;
        break;
      }
    }
    if ((pair != 1) || (triplet != 1)) {
      value = 0;
    }
    return value;
  }

  int Villa() {
    var value = 0;
    var threes = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] == 3) {
        value += (i + 1) * 3;
        threes++;
      }
    }
    if (threes != 2) {
      value = 0;
    }
    return value;
  }

  int SmallLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (_gameType == 'Ordinary') {
      // Text is not displayed and therefore not translated
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0)) {
        value = 1 + 2 + 3 + 4 + 5;
      }
    }
    if (_gameType == 'Mini') {
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0)) {
        value = 1 + 2 + 3 + 4;
      }
    }
    if (_gameType == 'Maxi') {
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0)) {
        value = 1 + 2 + 3 + 4 + 5;
      }
    }
    return value;
  }

  int LargeLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (_gameType == 'Ordinary') {
      if ((diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 2 + 3 + 4 + 5 + 6;
      }
    }
    if (_gameType == 'Mini') {
      if ((diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 3 + 4 + 5 + 6;
      }
    }
    if (_gameType == 'Maxi') {
      if ((diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 2 + 3 + 4 + 5 + 6;
      }
    }
    return value;
  }

  int MiddleLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (_gameType == 'Mini') {
      if ((diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0)) {
        value = 2 + 3 + 4 + 5;
      }
    }
    return value;
  }

  int FullLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (_gameType == 'Maxi') {
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 1 + 2 + 3 + 4 + 5 + 6;
      }
    }
    return value;
  }

  int Chance() {
    var value = 0;

    for (var i = 0; i < _dices._nrDices; i++) {
      value += _dices._diceValue[i];
    }
    return value;
  }
}
