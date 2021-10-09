part of '../../main.dart';

extension HighscoreWidget on Highscore {
  Widget WidgetHighscore(double width, double height) {
    var containerWidth = width;
    var heightCaption = height / 6.4;
    var containerHeight = height - heightCaption;
    var left = 0.0, top = 0.0;

    List<Widget> listings = <Widget>[];

    listings.add(Positioned(
        left: left,
        top: top,
        child: Container(
            width: containerWidth,
            height: heightCaption,
            child: Center(
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(Highscores_,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue[800],
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.red,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        )))))));

    listings.add(AnimatedBuilder(
        animation: animationsHighscore.AnimController,
        builder: (BuildContext context, Widget? widget) {
          return Positioned(
            left: left,
            top: top + heightCaption,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlueAccent.withOpacity(0.7),
                      Colors.indigoAccent.withOpacity(0.7)
                    ],
                    stops: [0.0, animationsHighscore.LoopAnimation.value],
                  )),
              child: Scrollbar(
                //showTrackOnHover: true,
                child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: HighscoreText.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: heightCaption,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          "  " + (index + 1).toString() + '.',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)))),
                              Container(
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(HighscoreText[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)))),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          HighscoreValue[index].toString() +
                                              "  ",
                                          style:
                                              TextStyle(color: Colors.yellow))))
                            ]),
                      );
                    }),
              ),
            ),
          );
        }));
    return Container(
        width: width, height: height, child: Stack(children: listings));
  }
}
