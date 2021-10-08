part of '../main.dart';

class AnimationsBoardEffect {
  AnimationsBoardEffect() {
    Setup();
    print('setup animation');
  }

  final _animControllers = <AnimationController>[];

  List<Duration> _animDurations = List.filled(2, Duration(seconds: 1));
  var _cellAnimationControllers = [];
  var _cellAnimation = [];

  AnimateBoard() {
    for (int i = 0; i < application._nrPlayers + 1; i++) {
      _cellAnimationControllers[i][0].forward();
    }
  }

  void Setup() {
    _animDurations.forEach((Duration d) {
      _animControllers.add(AnimationController(
        vsync: _MainAppHandlerState(),
        duration: d,
      ));
    });

    _animControllers[0].addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animControllers[0].reverse();
      }
    });

    for (int i = 0; i < application._maxNrPlayers + 1; i++) {
      var tmp = <AnimationController>[];
      //List<Animation> tmp2 = [];
      for (int j = 0; j < application._maxTotalFields; j++) {
        tmp.add(AnimationController(
          vsync: _MainAppHandlerState(),
          duration: Duration(milliseconds: 500),
        ));
      }
      _cellAnimationControllers.add(tmp);
    }

    for (int i = 0; i < application._maxNrPlayers + 1; i++) {
      var tmp = <Animation>[];
      for (int j = 0; j < application._maxTotalFields; j++) {
        tmp.add(new CurveTween(curve: Curves.easeInSine)
            .animate(_cellAnimationControllers[i][j]));
      }
      _cellAnimation.add(tmp);
    }

    for (int i = 0; i < application._maxNrPlayers + 1; i++) {
      for (int j = 0; j < application._maxTotalFields; j++) {
        _cellAnimationControllers[i][j].addListener(() {
          application._boardXAnimationPos[i][j] =
              _cellAnimation[i][j].value * 100.0;
          if ((j < application._maxTotalFields - 1) &&
              _cellAnimation[i][j].value > 0.02) {
            if (!_cellAnimationControllers[i][j + 1].isAnimating) {
              _cellAnimationControllers[i][j + 1].forward();
            }
          }
        });
        _cellAnimationControllers[i][j]
            .addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _cellAnimationControllers[i][j].reverse();
          }
        });
      }
    }
  }
}
