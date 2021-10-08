part of '../main.dart';

class AnimationsScroll extends LanguagesAnimationsScroll {
  AnimationsScroll(GlobalKey key) {
    _key = key;
    Setup();
  }

  double scrollWidth = 350;
  double scrollHeight = 200;
  double keyXPos = 0, keyYPos = 0;
  int counterR = 0, counterG = 0, counterB = 0;
  TextStyle scrollTextStyle = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0),
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    letterSpacing: 3,
    wordSpacing: 3,
  );

  AnimationController _animationController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(seconds: 1));

  late Animation<double> _positionAnimation;
  late GlobalKey _key;

  // Size calcTextSize(String text, TextStyle style) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     textDirection: TextDirection.ltr,
  //     //textScaleFactor: MediaQuery.of(context).textScaleFactor,
  //     textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
  //   )..layout();
  //   return textPainter.size;
  // }

  Setup() {
    _positionAnimation =
        CurveTween(curve: Curves.linear).animate(_animationController);

    _animationController.addListener(() {
      RenderBox box = _key.currentContext?.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      keyXPos = position.dx;
      keyYPos = position.dy;
      scrollWidth = emptyContainerKey.currentContext!.size!.width;
      scrollHeight = emptyContainerKey.currentContext!.size!.height;
      counterR = counterR + 3;
      counterG = counterG + 2;
      counterB = counterB + 1;
      scrollTextStyle = TextStyle(
        color: Color.fromRGBO(
            100 - (counterR % 100), counterG % 100, counterB % 256, 1.0),
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        letterSpacing: 3,
        wordSpacing: 3,
      );

      keyYPos += _positionAnimation.value * 30;
    });
    stackedWidgets.add(widgetAnimationsScroll());
  }
}
