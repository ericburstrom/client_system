part of '../main.dart';

class AnimationsRollDices {
  AnimationsRollDices() {
    Setup();
  }

  AnimationController AnimController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(milliseconds: 300));
  late Animation<double> SizeAnimation;

  Setup() {
    SizeAnimation =
        CurveTween(curve: Curves.easeInSine).animate(AnimController);

    AnimController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        AnimController.reverse();
      }
    });
  }
}
