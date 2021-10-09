part of '../main.dart';

class AnimationsScroll extends LanguagesAnimationsScroll {
  AnimationsScroll(GlobalKey key) {
    Key = key;
    Setup();
  }

  double SizeAnimation = 350;
  double ScrollHeight = 200;
  double KeyXPos = 0, KeyYPos = 0;
  int CounterR = 0, CounterG = 0, CounterB = 0;
  TextStyle ScrollTextStyle = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0),
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    letterSpacing: 3,
    wordSpacing: 3,
  );

  AnimationController AnimController = AnimationController(
      vsync: _MainAppHandlerState(), duration: Duration(seconds: 1));

  late Animation<double> PositionAnimation;
  late GlobalKey Key;

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
    PositionAnimation =
        CurveTween(curve: Curves.linear).animate(AnimController);

    AnimController.addListener(() {
      RenderBox box = Key.currentContext?.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      KeyXPos = position.dx;
      KeyYPos = position.dy;
      SizeAnimation = emptyContainerKey.currentContext!.size!.width;
      ScrollHeight = emptyContainerKey.currentContext!.size!.height;
      CounterR = CounterR + 3;
      CounterG = CounterG + 2;
      CounterB = CounterB + 1;
      ScrollTextStyle = TextStyle(
        color: Color.fromRGBO(
            100 - (CounterR % 100), CounterG % 100, CounterB % 256, 1.0),
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        letterSpacing: 3,
        wordSpacing: 3,
      );

      KeyYPos += PositionAnimation.value * 30;
    });
    stackedWidgets.add(widgetAnimationsScroll());
  }
}
