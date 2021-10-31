part of '../program.dart';

extension GameCalcDiceValues on Application {
  int Zero() {
    return 0;
  }

  int CalcOnes() {
    var eye = 1;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int CalcTwos() {
    var eye = 2;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int CalcThrees() {
    var eye = 3;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int CalcFours() {
    var eye = 4;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int CalcFives() {
    var eye = 5;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  int CalcSixes() {
    var eye = 6;
    var value = 0;
    for (var i = 0; i < GameDices.NrDices; i++) {
      if (GameDices.DiceValue[i] == eye) {
        value += eye;
      }
    }
    return value;
  }

  List CalcDiceNr() {
    var tmp = List.filled(6, 0);
    for (var i = 0; i < GameDices.NrDices; i++) {
      tmp[GameDices.DiceValue[i] - 1]++;
    }
    return tmp;
  }

  int CalcPair() {
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

  int CalcTwoPairs() {
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

  int CalcThreePairs() {
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

  int CalcThreeOfKind() {
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

  int CalcFourOfKind() {
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

  int CalcFiveOfKind() {
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

  int CalcYatzy() {
    var value = 0;
    var diceNr = CalcDiceNr();
    for (var i = 5; i >= 0; i--) {
      if (diceNr[i] == GameDices.NrDices) {
        if (GameDices.NrDices == 4) {
          value = 25;
        }
        if (GameDices.NrDices == 5) {
          value = 50;
        }
        if (GameDices.NrDices == 6) {
          value = 100;
        }
      }
    }
    return value;
  }

  int CalcHouse() {
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

  int CalcTower() {
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

  int CalcVilla() {
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

  int CalcSmallLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (GameType == 'Ordinary') {
      // Text is not displayed and therefore not translated
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0)) {
        value = 1 + 2 + 3 + 4 + 5;
      }
    }
    if (GameType == 'Mini') {
      if ((diceNr[0] > 0) &&
          (diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0)) {
        value = 1 + 2 + 3 + 4;
      }
    }
    if (GameType == 'Maxi') {
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

  int CalcLargeLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (GameType == 'Ordinary') {
      if ((diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 2 + 3 + 4 + 5 + 6;
      }
    }
    if (GameType == 'Mini') {
      if ((diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0) &&
          (diceNr[5] > 0)) {
        value = 3 + 4 + 5 + 6;
      }
    }
    if (GameType == 'Maxi') {
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

  int CalcMiddleLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (GameType == 'Mini') {
      if ((diceNr[1] > 0) &&
          (diceNr[2] > 0) &&
          (diceNr[3] > 0) &&
          (diceNr[4] > 0)) {
        value = 2 + 3 + 4 + 5;
      }
    }
    return value;
  }

  int CalcFullLadder() {
    var value = 0;
    var diceNr = CalcDiceNr();
    if (GameType == 'Maxi') {
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

  int CalcChance() {
    var value = 0;

    for (var i = 0; i < GameDices.NrDices; i++) {
      value += GameDices.DiceValue[i];
    }
    return value;
  }
}
