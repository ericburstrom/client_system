part of '../main.dart';

// cannot have typedef inside class
typedef int YatzyFunctions();

class Application extends LanguagesApplication {
  Application() {
    _dices = new Dices(UpdateDiceValues);
    LanguagesSetup();
    Setup('Ordinary', 2);
  }

  // Used by animations
  int _maxNrPlayers = 4;
  int _maxTotalFields = 23;

  // 'Ordinary' , 'Mini', 'Maxi'
  String _gameType = 'Ordinary';

  var _totalFields;

  var _boardXPos,
      _boardYPos,
      _boardWidth,
      _boardHeight,
      _boardXAnimationPos,
      _boardYAnimationPos;

  int _nrPlayers = 2;
  int _bonusSum = 63;
  int _bonusAmount = 50;

  var _cellValue;

  int _myPlayerId = -1;
  int _playerToMove = 0;
  var _fixedCell;
  var _text;
  var _colors;
  var _focusStatus;
  GlobalKey _listenerKey = new GlobalKey();

  /*
  var _cellKeys = [];
  for (int i = 0; i < _nrPlayers + 1; i++) {
  List<GlobalKey> tmp = [];
  for (int j = 0; j < _totalFields; j++) {
  tmp.add(new GlobalKey());
  }
  _cellKeys.add(tmp);
  }
   */

  late Dices _dices;

  late List<YatzyFunctions> _yatzyFunctions;

  //LanguagesYatzy lang = new LanguagesYatzy();

  UpdateDiceValues() {
    ClearFocus();
    for (var i = 0; i < _totalFields; i++) {
      if (!_fixedCell[_playerToMove][i]) {
        _cellValue[_playerToMove][i] = _yatzyFunctions[i]();
        _text[_playerToMove + 1][i] = _cellValue[_playerToMove][i].toString();
      }
    }
  }

  Setup(String gameType, int nrPlayers) {
    _gameType = gameType;
    _nrPlayers = nrPlayers;
    _playerToMove = 0;

    if (_gameType == 'Mini') {
      _totalFields = 17;
      _dices.InitDices(4);
      _bonusSum = 50;
      _bonusAmount = 25;
      _text = [
        [
          GetText(_ones),
          GetText(_twos),
          GetText(_threes),
          GetText(_fours),
          GetText(_fives),
          GetText(_sixes),
          GetText(_sum),
          GetText(_bonus) + ' (' + _bonusAmount.toString() + ')',
          GetText(_pair),
          GetText(_twoPairs),
          GetText(_threeOfKind),
          GetText(_smallStraight),
          GetText(_middleStraight),
          GetText(_largeStraight),
          GetText(_chance),
          GetText(_yatzy),
          GetText(_totalSum)
        ]
      ];
      _yatzyFunctions = [Ones, Twos, Threes, Fours, Fives, Sixes] +
          [
            Zero,
            Zero,
            Pair,
            TwoPairs,
            ThreeOfKind,
            SmallLadder,
            MiddleLadder,
            LargeLadder,
            Chance,
            Yatzy,
            Zero
          ];
    } else if (_gameType == 'Maxi') {
      _totalFields = 23;
      _dices.InitDices(6);
      _bonusSum = 84;
      _bonusAmount = 100;
      _text = [
        [
          GetText(_ones),
          GetText(_twos),
          GetText(_threes),
          GetText(_fours),
          GetText(_fives),
          GetText(_sixes),
          GetText(_sum),
          GetText(_bonus) + ' (' + _bonusAmount.toString() + ')',
          GetText(_pair),
          GetText(_twoPairs),
          GetText(_threePairs),
          GetText(_threeOfKind),
          GetText(_fourOfKind),
          GetText(_fiveOfKind),
          GetText(_smallStraight),
          GetText(_largeStraight),
          GetText(_fullStraight),
          GetText(_house32),
          GetText(_house33),
          GetText(_house24),
          GetText(_chance),
          GetText(_maxiYatzy),
          GetText(_totalSum)
        ]
      ];
      _yatzyFunctions = [Ones, Twos, Threes, Fours, Fives, Sixes] +
          [
            Zero,
            Zero,
            Pair,
            TwoPairs,
            ThreePairs,
            ThreeOfKind,
            FourOfKind,
            FiveOfKind,
            SmallLadder,
            LargeLadder,
            FullLadder,
            House,
            Villa,
            Tower,
            Chance,
            Yatzy,
            Zero
          ];
    } else {
      _totalFields = 18;
      _dices.InitDices(5);
      _bonusSum = 63;
      _bonusAmount = 50;
      _text = [
        [
          GetText(_ones),
          GetText(_twos),
          GetText(_threes),
          GetText(_fours),
          GetText(_fives),
          GetText(_sixes),
          GetText(_sum),
          GetText(_bonus) + ' (' + _bonusAmount.toString() + ')',
          GetText(_pair),
          GetText(_twoPairs),
          GetText(_threeOfKind),
          GetText(_fourOfKind),
          GetText(_house),
          GetText(_smallStraight),
          GetText(_largeStraight),
          GetText(_chance),
          GetText(_yatzy),
          GetText(_totalSum)
        ]
      ];
      _yatzyFunctions = [Ones, Twos, Threes, Fours, Fives, Sixes] +
          [
            Zero,
            Zero,
            Pair,
            TwoPairs,
            ThreeOfKind,
            FourOfKind,
            House,
            SmallLadder,
            LargeLadder,
            Chance,
            Yatzy,
            Zero
          ];
    }

    for (int i = 0; i < _nrPlayers; i++) {
      _text.add(List.filled(6, '') +
          List.filled(1, '0') +
          List.filled(1, (-_bonusSum).toString()) +
          List.filled(_totalFields - 9, '') +
          List.filled(1, '0'));
    }
    //_boardXPos = List.filled(_nrPlayers, [List.filled(_totalFields, 0.0)]);
    _boardXPos = [List.filled(_maxTotalFields, 0.0)];
    _boardYPos = [List.filled(_maxTotalFields, 0.0)];
    _boardWidth = [List.filled(_maxTotalFields, 0.0)];
    _boardHeight = [List.filled(_maxTotalFields, 0.0)];
    _boardXAnimationPos = [List.filled(_maxTotalFields, 0.0)];
    _boardYAnimationPos = [List.filled(_maxTotalFields, 0.0)];
    for (int i = 0; i < _maxNrPlayers; i++) {
      _boardXPos.add(List.filled(_maxTotalFields, 0.0));
      _boardYPos.add(List.filled(_maxTotalFields, 0.0));
      _boardWidth.add(List.filled(_maxTotalFields, 0.0));
      _boardHeight.add(List.filled(_maxTotalFields, 0.0));
      _boardXAnimationPos.add(List.filled(_maxTotalFields, 0.0));
      _boardYAnimationPos.add(List.filled(_maxTotalFields, 0.0));
    }
    ClearFocus();
    _fixedCell = [];
    _cellValue = [];
    _colors = [
      List.filled(6, Colors.white.withOpacity(0.3)) +
          List.filled(2, Colors.blueAccent.withOpacity(0.8)) +
          List.filled(_totalFields - 9, Colors.white.withOpacity(0.3)) +
          List.filled(1, Colors.blueAccent.withOpacity(0.8))
    ];
    for (int i = 0; i < _nrPlayers; i++) {
      _fixedCell.add(List.filled(6, false) +
          [true, true] +
          List.filled(_totalFields - 9, false) +
          [true]);
      //game.fixedCell.add([false]+List.filled(5, true) + [true, true] + List.filled(game.totalFields-9, true) + [true]);//trick to end game fast
      if (i == _playerToMove) {
        _colors.add(List.filled(6, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(_totalFields - 9, Colors.greenAccent.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      } else {
        _colors.add(List.filled(6, Colors.grey.withOpacity(0.3)) +
            List.filled(2, Colors.blue.withOpacity(0.3)) +
            List.filled(_totalFields - 9, Colors.grey.withOpacity(0.3)) +
            List.filled(1, Colors.blue.withOpacity(0.3)));
      }
      _cellValue.add(List.filled(_totalFields, -1));
    }
    if (_dices._unityCreated) {
      _dices.SendResetToUnity();
    }
  }
}
