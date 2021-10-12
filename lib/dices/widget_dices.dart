part of '../main.dart';

extension DicesWidget on Dices {
  Widget WidgetDices(double width, double height) {
    // First always start unity and hide if only 2D
    // Get best 16:9 fit
    var left = 0.0, top = 0.0, w = width, h = height, ratio = 16 / 9;
    if (width / height < ratio) {
      h = width / ratio;
      top = (height - h) / 2;
    } else {
      w = height * ratio;
      left = (width - w) / 2;
    }
    if (!UnityDices[0]) {
      left = screenWidth;
      top = screenHeight;
    }

    if (UnityDices[0]) {
      Widget widgetUnity = Positioned(
          left: left,
          top: top,
          child: Container(
              width: w,
              height: h,
              child: UnityWidget(
                borderRadius: BorderRadius.zero,
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                //onUnitySceneLoaded: onUnitySceneLoaded,
                fullscreen: false,
              )));

      return Container(
          width: width, height: height, child: Stack(children: [widgetUnity]));
    }

    var orientationPortrait = (screenHeight > screenWidth) ? 1 : 0;
    double diceWidthHeight;

    left = 0;
    top = 0;
    var listings = <Widget>[];
    //listings.add(widgetUnity);

    // Spread dices evenly and place roll dice button under or at the side of.
    // The number 3.5 is assuming spacing is half dice 2 dices plus spacing between and around
    // Scaling 2 * NrDices instead of optimal (3*NrDices+1)/2 is to group dices more in portrait mode
    // Min 60 is to prevent too large dices
    if (orientationPortrait == 1) {
      diceWidthHeight = width / (2 * NrDices);
      left =
          diceWidthHeight / 2 + (width - diceWidthHeight * (2 * NrDices)) / 2;
      top = min(diceWidthHeight / 2,
          diceWidthHeight / 2 + (height - diceWidthHeight * 3.5) / 2);
    } else {
      diceWidthHeight = height / (2 * NrDices);
      left = diceWidthHeight / 2;
      top =
          diceWidthHeight / 2 + (height - diceWidthHeight * (2 * NrDices)) / 2;
    }

    for (var i = 0; i < NrDices; i++) {
      listings.add(
        Positioned(
            left: left + 2 * diceWidthHeight * i * orientationPortrait,
            top: top + 2 * diceWidthHeight * i * (1 - orientationPortrait),
            child: Container(
              width: diceWidthHeight,
              height: diceWidthHeight,
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.3)),
              child: Image.asset(DiceRef[i]),
            )),
      );
      listings.add(Positioned(
        left: left + 2 * diceWidthHeight * i * orientationPortrait,
        top: top + 2 * diceWidthHeight * i * (1 - orientationPortrait),
        child: GestureDetector(
            onTap: () {
              HoldDice(i);
              globalSetState();
            },
            child: Container(
              width: diceWidthHeight,
              height: diceWidthHeight,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(HoldDiceOpacity[i])),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  HoldDiceText[i],
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  //fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                //),
              ),
            )),
      ));
    }

    // Roll button
    listings.add(AnimatedBuilder(
      animation: AnimController,
      builder: (BuildContext context, Widget? widget) {
        final tmp = Listener(
            onPointerDown: (e) {
              print(application.PlayerToMove);
              print(application.MyPlayerId);
              if (application.PlayerToMove != application.MyPlayerId) {
                return;
              }
              if (RollDices()) {
                AnimController.forward();
                globalSetState();
              }
            },
            child: Container(
              width: diceWidthHeight * (1 - SizeAnimation.value / 2),
              height: diceWidthHeight * (1 - SizeAnimation.value / 2),
              decoration: BoxDecoration(color: Colors.red),
              child: Image.asset('assets/images/roll.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity),
            ));
        return Positioned(
          left: left +
              (NrDices - 1) * diceWidthHeight * orientationPortrait +
              1.5 * diceWidthHeight * (1 - orientationPortrait),
          top: top +
              1.5 * diceWidthHeight * orientationPortrait +
              (NrDices - 1) * diceWidthHeight * (1 - orientationPortrait),
          child: tmp,
        );
      },
    ));

    return Container(
        width: width, height: height, child: Stack(children: listings));
  }
}
