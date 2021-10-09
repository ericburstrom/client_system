part of '../main.dart';

// cannot have typedef inside class
typedef int YatzyFunctions();

class Application extends LanguagesApplication {
  Application() {
    GameDices = Dices(UpdateDiceValues);
    LanguagesSetup();
    Setup('Ordinary', 2);
  }

  // Used by animations
  var MaxNrPlayers = 4;
  var MaxTotalFields = 23;

  // 'Ordinary' , 'Mini', 'Maxi'
  var GameType = 'Ordinary';

  var TotalFields;

  var BoardXPos,
      BoardYPos,
      BoardWidth,
      BoardHeight,
      BoardXAnimationPos,
      BoardYAnimationPos;

  var NrPlayers = 2;
  var BonusSum = 63;
  var BonusAmount = 50;

  var CellValue;

  var MyPlayerId = 0; // -1
  var PlayerToMove = 0;
  var FixedCell;
  var AppText;
  var AppColors;
  var FocusStatus;
  var ListenerKey = GlobalKey();

  /*
  var _cellKeys = [];
  for (int i = 0; i < NrPlayers + 1; i++) {
  List<GlobalKey> tmp = [];
  for (int j = 0; j < TotalFields; j++) {
  tmp.add(new GlobalKey());
  }
  _cellKeys.add(tmp);
  }
   */

  late Dices GameDices;

  late List<YatzyFunctions> YatzyFunc;

  //LanguagesYatzy lang = new LanguagesYatzy();

  UpdateDiceValues() {
    ClearFocus();
    for (var i = 0; i < TotalFields; i++) {
      if (!FixedCell[PlayerToMove][i]) {
        CellValue[PlayerToMove][i] = YatzyFunc[i]();
        AppText[PlayerToMove + 1][i] = CellValue[PlayerToMove][i].toString();
      }
    }
  }

  Setup(String gameType, int nrPlayers) {
    GameType = gameType;
    NrPlayers = nrPlayers;
    PlayerToMove = 0;

    if (GameType == 'Mini') {
      TotalFields = 17;
      GameDices.InitDices(4);
      BonusSum = 50;
      BonusAmount = 25;
      AppText = [
        [
          Ones,
          Twos,
          Threes,
          Fours,
          Fives,
          Sixes,
          Sum,
          Bonus + ' (' + BonusAmount.toString() + ')',
          Pair,
          TwoPairs,
          ThreeOfKind,
          SmallStraight,
          MiddleStraight,
          LargeStraight,
          Chance,
          Yatzy,
          TotalSum
        ]
      ];
      YatzyFunc =
          [CalcOnes, CalcTwos, CalcThrees, CalcFours, CalcFives, CalcSixes] +
              [
                Zero,
                Zero,
                CalcPair,
                CalcTwoPairs,
                CalcThreeOfKind,
                CalcSmallLadder,
                CalcMiddleLadder,
                CalcLargeLadder,
                CalcChance,
                CalcYatzy,
                Zero
              ];
    } else if (GameType == 'Maxi') {
      TotalFields = 23;
      GameDices.InitDices(6);
      BonusSum = 84;
      BonusAmount = 100;
      AppText = [
        [
          Ones,
          Twos,
          Threes,
          Fours,
          Fives,
          Sixes,
          Sum,
          Bonus + ' (' + BonusAmount.toString() + ')',
          Pair,
          TwoPairs,
          ThreePairs,
          ThreeOfKind,
          FourOfKind,
          FiveOfKind,
          SmallStraight,
          LargeStraight,
          FullStraight,
          House32,
          House33,
          House24,
          Chance,
          MaxiYatzy,
          TotalSum
        ]
      ];
      YatzyFunc =
          [CalcOnes, CalcTwos, CalcThrees, CalcFours, CalcFives, CalcSixes] +
              [
                Zero,
                Zero,
                CalcPair,
                CalcTwoPairs,
                CalcThreePairs,
                CalcThreeOfKind,
                CalcFourOfKind,
                CalcFiveOfKind,
                CalcSmallLadder,
                CalcLargeLadder,
                CalcFullLadder,
                CalcHouse,
                CalcVilla,
                CalcTower,
                CalcChance,
                CalcYatzy,
                Zero
              ];
    } else {
      TotalFields = 18;
      GameDices.InitDices(5);
      BonusSum = 63;
      BonusAmount = 50;
      AppText = [
        [
          Ones,
          Twos,
          Threes,
          Fours,
          Fives,
          Sixes,
          Sum,
          Bonus + ' (' + BonusAmount.toString() + ')',
          Pair,
          TwoPairs,
          ThreeOfKind,
          FourOfKind,
          House,
          SmallStraight,
          LargeStraight,
          Chance,
          Yatzy,
          TotalSum
        ]
      ];
      YatzyFunc =
          [CalcOnes, CalcTwos, CalcThrees, CalcFours, CalcFives, CalcSixes] +
              [
                Zero,
                Zero,
                CalcPair,
                CalcTwoPairs,
                CalcThreeOfKind,
                CalcFourOfKind,
                CalcHouse,
                CalcSmallLadder,
                CalcLargeLadder,
                CalcChance,
                CalcYatzy,
                Zero
              ];
    }

    for (var i = 0; i < NrPlayers; i++) {
      AppText.add(List.filled(6, '') +
          List.filled(1, '0') +
          List.filled(1, (-BonusSum).toString()) +
          List.filled(TotalFields - 9, '') +
          List.filled(1, '0'));
    }
    //BoardXPos = List.filled(NrPlayers, [List.filled(TotalFields, 0.0)]);
    BoardXPos = [List.filled(MaxTotalFields, 0.0)];
    BoardYPos = [List.filled(MaxTotalFields, 0.0)];
    BoardWidth = [List.filled(MaxTotalFields, 0.0)];
    BoardHeight = [List.filled(MaxTotalFields, 0.0)];
    BoardXAnimationPos = [List.filled(MaxTotalFields, 0.0)];
    BoardYAnimationPos = [List.filled(MaxTotalFields, 0.0)];
    for (var i = 0; i < MaxNrPlayers; i++) {
      BoardXPos.add(List.filled(MaxTotalFields, 0.0));
      BoardYPos.add(List.filled(MaxTotalFields, 0.0));
      BoardWidth.add(List.filled(MaxTotalFields, 0.0));
      BoardHeight.add(List.filled(MaxTotalFields, 0.0));
      BoardXAnimationPos.add(List.filled(MaxTotalFields, 0.0));
      BoardYAnimationPos.add(List.filled(MaxTotalFields, 0.0));
    }
    ClearFocus();
    FixedCell = [];
    CellValue = [];
    AppColors = [
      List.filled(6, Colors.white.withOpacity(0.3)) +
          List.filled(2, Colors.blueAccent.withOpacity(0.8)) +
          List.filled(TotalFields - 9, Colors.white.withOpacity(0.3)) +
          List.filled(1, Colors.blueAccent.withOpacity(0.8))
    ];
    for (var i = 0; i < NrPlayers; i++) {
      FixedCell.add(List.filled(6, false) +
          [true, true] +
          List.filled(TotalFields - 9, false) +
          [true]);
      //game.fixedCell.add([false]+List.filled(5, true) + [true, true] + List.filled(game.totalFields-9, true) + [true]);//trick to end game fast
      if (i == PlayerToMove) {
        AppColors.add(List.filled(6, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(TotalFields - 9, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      } else {
        AppColors.add(List.filled(6, Colors.grey.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(TotalFields - 9, Colors.grey.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      }
      CellValue.add(List.filled(TotalFields, -1));
    }
    if (GameDices.UnityCreated) {
      GameDices.SendResetToUnity();
    }
  }
}
