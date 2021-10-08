part of '../../main.dart';

extension WidgetAnimationsScroll on AnimationsScroll {
  Widget widgetAnimationsScroll() {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? widget) {
          List<String> text = GetText(_scrollText).split('.');
          List<AnimatedText> animatedTexts = [];
          text.forEach((element) {
            animatedTexts.add(FadeAnimatedText(element));
          });
          return new Positioned(
              left: keyXPos,
              top: keyYPos,
              child: Container(
                  width: scrollWidth,
                  height: scrollHeight,
                  child: FittedBox(
                    child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: animatedTexts,
                          repeatForever: true,
                        )),
                  )));
        });
  }
}
