part of '../program.dart';

class AnimationsRollDices {
  var AnimController = AnimationController(
      vsync: _MainAppHandlerState(),
      duration: const Duration(milliseconds: 300));
  late Animation<double> SizeAnimation;

  SetupAnimation() {
    SizeAnimation =
        CurveTween(curve: Curves.easeInSine).animate(AnimController);

    AnimController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        AnimController.reverse();
      }
    });
  }
}
