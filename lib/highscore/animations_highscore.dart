part of '../main.dart';

class AnimationsHighscore {
  var AnimController = AnimationController(
      vsync: _MainAppHandlerState(),
      duration: const Duration(milliseconds: 3000));
  late Animation<double> LoopAnimation;

  SetupAnimation() {
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
