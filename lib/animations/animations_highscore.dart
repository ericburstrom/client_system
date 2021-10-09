part of '../main.dart';

class AnimationsHighscore {
  AnimationsHighscore() {
    Setup();
  }

  var AnimController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(milliseconds: 3000));
  late Animation<double> LoopAnimation;

  Setup() {
    LoopAnimation =
        CurveTween(curve: Curves.easeInSine).animate(AnimController);

    AnimController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        AnimController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        AnimController.forward();
      }
    });
    AnimController.forward();
  }
}
