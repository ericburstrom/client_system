part of '../main.dart';

class AnimationsBoardEffect {
  AnimationsBoardEffect() {
    Setup();
  }

  final AnimationControllers = <AnimationController>[];

  List<Duration> AnimationDurations = List.filled(2, Duration(seconds: 1));
  var CellAnimationControllers = [];
  var CellAnimation = [];

  AnimateBoard() {
    for (var i = 0; i < application.NrPlayers + 1; i++) {
      CellAnimationControllers[i][0].forward();
    }
  }

  void Setup() {
    AnimationDurations.forEach((Duration d) {
      AnimationControllers.add(AnimationController(
        vsync: _MainAppHandlerState(),
        duration: d,
      ));
    });

    AnimationControllers[0].addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        AnimationControllers[0].reverse();
      }
    });

    for (var i = 0; i < application.MaxNrPlayers + 1; i++) {
      var tmp = <AnimationController>[];
      for (var j = 0; j < application.MaxTotalFields; j++) {
        tmp.add(AnimationController(
          vsync: _MainAppHandlerState(),
          duration: Duration(milliseconds: 500),
        ));
      }
      CellAnimationControllers.add(tmp);
    }

    for (var i = 0; i < application.MaxNrPlayers + 1; i++) {
      var tmp = <Animation>[];
      for (var j = 0; j < application.MaxTotalFields; j++) {
        tmp.add(CurveTween(curve: Curves.easeInSine)
            .animate(CellAnimationControllers[i][j]));
      }
      CellAnimation.add(tmp);
    }

    for (var i = 0; i < application.MaxNrPlayers + 1; i++) {
      for (var j = 0; j < application.MaxTotalFields; j++) {
        CellAnimationControllers[i][j].addListener(() {
          application.BoardXAnimationPos[i][j] =
              CellAnimation[i][j].value * 100.0;
          if ((j < application.MaxTotalFields - 1) &&
              CellAnimation[i][j].value > 0.02) {
            if (!CellAnimationControllers[i][j + 1].isAnimating) {
              CellAnimationControllers[i][j + 1].forward();
            }
          }
        });
        CellAnimationControllers[i][j]
            .addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            CellAnimationControllers[i][j].reverse();
          }
        });
      }
    }
  }
}
