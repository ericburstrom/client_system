part of '../main.dart';

class AnimationsHighscore {
  AnimationsHighscore() {
    Setup();
  }

  AnimationController _animController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(milliseconds: 3000));
  late Animation<double> _loopAnimation;

  Setup() {
    _loopAnimation =
        CurveTween(curve: Curves.easeInSine).animate(_animController);

    _animController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animController.forward();
      }
    });
    _animController.forward();
  }
}
