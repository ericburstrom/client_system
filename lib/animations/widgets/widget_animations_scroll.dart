part of '../../main.dart';

extension WidgetAnimationsScroll on AnimationsScroll {
  Widget widgetAnimationsScroll() {
    return AnimatedBuilder(
        animation: AnimController,
        builder: (BuildContext context, Widget? widget) {
          List<String> text = GetText(ScrollText).split('.');
          List<AnimatedText> animatedTexts = [];
          text.forEach((element) {
            animatedTexts.add(FadeAnimatedText(element));
          });
          return Positioned(
              left: KeyXPos,
              top: KeyYPos,
              child: Container(
                  width: SizeAnimation,
                  height: ScrollHeight,
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
