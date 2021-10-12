part of '../main.dart';

extension ApplicationWidgets on Application {
  MainOnDrag(mainX, mainY) {
    if (application.PlayerToMove != application.MyPlayerId) {
      return;
    }

    //print(ListenerKey.currentContext.size);
    var box = ListenerKey.currentContext!.findRenderObject() as RenderBox;
    var position = box.localToGlobal(Offset.zero); //this is global position
    mainY -= position.dy;
    for (var i = 0; i < TotalFields; i++) {
      if (mainY >= BoardYPos[0][i] &&
          mainY <= BoardYPos[0][i] + BoardHeight[0][i]) {
        if (!FixedCell[PlayerToMove][i] && CellValue[PlayerToMove][i] != -1) {
          if (FocusStatus[PlayerToMove][i] == 0) {
            ClearFocus();
            FocusStatus[PlayerToMove][i] = 1;
          }
        }
      }
    }
  }

  Widget WidgetSetupGameBoard(double width, double height) {
    var cellWidth = min(120.0, width / ((NrPlayers) / 3 + 1.5));
    var left = (width - cellWidth * ((NrPlayers - 1) / 3 + 1.5)) / 2;
    var cellHeight = min(30.0, height / (TotalFields + 1));
    var top = (height - cellHeight * TotalFields) / 2;

    // Setup board cell positions
    for (var i = 0; i < TotalFields; i++) {
      BoardWidth[0][i] = cellWidth;
      BoardHeight[0][i] = cellHeight;
      BoardXPos[0][i] = left;
      BoardYPos[0][i] = i * cellHeight + top;
    }

    for (var i = 0; i < NrPlayers; i++) {
      for (var j = 0; j < TotalFields; j++) {
        BoardXPos[i + 1][j] = BoardXPos[i][j] + BoardWidth[i][j];
        BoardYPos[i + 1][j] = BoardYPos[0][j];
        BoardHeight[i + 1][j] = BoardHeight[0][j];
        if (i == PlayerToMove) {
          BoardWidth[i + 1][j] = BoardWidth[0][j] / 2;
        } else {
          BoardWidth[i + 1][j] = BoardWidth[0][j] / 3;
        }
      }
    }

    for (var i = 0; i < NrPlayers; i++) {
      for (var j = 0; j < TotalFields; j++) {
        // enlarge dimension of cell in focus
        if (FocusStatus[i][j] == 1) {
          BoardXPos[i + 1][j] -= BoardWidth[0][j] / 4;
          BoardWidth[i + 1][j] *= 2;
          BoardYPos[i + 1][j] -= BoardHeight[0][j] / 2;
          BoardHeight[i + 1][j] *= 2;
        }
      }
    }

    var listings = <Widget>[];

    for (var i = 0; i < TotalFields; i++) {
      listings.add(
        AnimatedBuilder(
            animation: CellAnimationControllers[0][i],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                  //key: _cellKeys[0][i],
                  left: BoardXPos[0][i] + BoardXAnimationPos[0][i],
                  top: BoardYPos[0][i] + BoardYAnimationPos[0][i],
                  child: Container(
                    width: BoardWidth[0][i],
                    height: BoardHeight[0][i],
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: AppColors[0][i],
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        AppText[0][i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //color: Colors.blue[800],
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.blue,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ));
            }),
      );
    }

    // add listener object to get drag positions
    // Important it comes after the part over which it should trigger
    listings.add(GestureDetector(
        key: ListenerKey,
        onVerticalDragUpdate: (d) {
          MainOnDrag(d.globalPosition.dx, d.globalPosition.dy);
          globalSetState();
        },
        child: Container(width: width, height: height, child: Text(""))));

    Widget? focusWidget;
    Widget tmpWidget;
    for (var i = 0; i < NrPlayers; i++) {
      for (var j = 0; j < TotalFields; j++) {
        tmpWidget = AnimatedBuilder(
            animation: CellAnimationControllers[i][j],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                //key: _cellKeys[i + 1][j],
                left: BoardXPos[i + 1][j] + BoardXAnimationPos[i + 1][j],
                top: BoardYPos[i + 1][j] + BoardYAnimationPos[i + 1][j],
                child: GestureDetector(
                    onTap: () {
                      CellClick(i, j);
                      globalSetState();
                    },
                    child: Container(
                        width: BoardWidth[i + 1][j],
                        height: BoardHeight[i + 1][j],
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors[i + 1][j],
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(AppText[i + 1][j],
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ))),
              );
            });
        if (FocusStatus[i][j] == 1) {
          focusWidget = tmpWidget;
        } else {
          listings.add(tmpWidget);
        }
      }
    }
    // The focus widget is overlapping neighbor widgets
    // it needs to be last to have priority
    if (focusWidget != null) {
      listings.add(focusWidget);
    }
    return Container(
        width: screenWidth, height: height, child: Stack(children: listings));
  }
}
