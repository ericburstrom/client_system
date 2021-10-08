part of '../main.dart';

class AnimationsRollDices {
  AnimationsRollDices() {
    Setup();
  }

  AnimationController _animController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(milliseconds: 300));
  late Animation<double> _sizeAnimation;

  Setup() {
    _sizeAnimation =
        CurveTween(curve: Curves.easeInSine).animate(_animController);

    _animController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animController.reverse();
      }
    });
  }
}
