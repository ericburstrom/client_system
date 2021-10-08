part of '../../main.dart';

extension WidgetSetupGameBoard on Application {
  MainOnDrag(mainX, mainY) {
    if (application._playerToMove != application._myPlayerId) {
      return;
    }
    //print(_listenerKey.currentContext.size);
    RenderBox box =
        _listenerKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    mainY -= position.dy;
    var cell;
    for (var i = 0; i < _totalFields; i++) {
      if ( //mainX >= _boardXPos[0][i] &&
          //mainX <= _boardXPos[0][i] + _boardWidth[0][i] &&
          mainY >= _boardYPos[0][i] &&
              mainY <= _boardYPos[0][i] + _boardHeight[0][i]) {
        cell = i;
        if (!_fixedCell[_playerToMove][cell] &&
            _cellValue[_playerToMove][cell] != -1) {
          if (_focusStatus[_playerToMove][cell] == 0) {
            ClearFocus();
            _focusStatus[_playerToMove][cell] = 1;
          }
        }
      }
    }
  }

  Widget widgetSetupGameBoard(double width, double height) {
    double cellWidth = min(120, width / ((_nrPlayers) / 3 + 1.5));
    double left = (width - cellWidth * ((_nrPlayers - 1) / 3 + 1.5)) / 2;
    double cellHeight = min(30, height / (_totalFields + 1));
    double top = (height - cellHeight * _totalFields) / 2;

    // Setup board cell positions
    for (var i = 0; i < _totalFields; i++) {
      _boardWidth[0][i] = cellWidth;
      _boardHeight[0][i] = cellHeight;
      _boardXPos[0][i] = left;
      _boardYPos[0][i] = i * cellHeight + top;
    }

    for (var i = 0; i < _nrPlayers; i++) {
      for (var j = 0; j < _totalFields; j++) {
        _boardXPos[i + 1][j] = _boardXPos[i][j] + _boardWidth[i][j];
        _boardYPos[i + 1][j] = _boardYPos[0][j];
        _boardHeight[i + 1][j] = _boardHeight[0][j];
        if (i == _playerToMove) {
          _boardWidth[i + 1][j] = _boardWidth[0][j] / 2;
        } else {
          _boardWidth[i + 1][j] = _boardWidth[0][j] / 3;
        }
      }
    }

    for (var i = 0; i < _nrPlayers; i++) {
      for (var j = 0; j < _totalFields; j++) {
        // enlarge dimension of cell in focus
        if (_focusStatus[i][j] == 1) {
          _boardXPos[i + 1][j] -= _boardWidth[0][j] / 4;
          _boardWidth[i + 1][j] *= 2;
          _boardYPos[i + 1][j] -= _boardHeight[0][j] / 2;
          _boardHeight[i + 1][j] *= 2;
        }
      }
    }

    List<Widget> listings = <Widget>[];

    for (var i = 0; i < _totalFields; i++) {
      listings.add(
        AnimatedBuilder(
            animation: animationBoardEffect._cellAnimationControllers[0][i],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                  //key: _cellKeys[0][i],
                  left: _boardXPos[0][i] + _boardXAnimationPos[0][i],
                  top: _boardYPos[0][i] + _boardYAnimationPos[0][i],
                  child: Container(
                    width: _boardWidth[0][i],
                    height: _boardHeight[0][i],
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: _colors[0][i],
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        _text[0][i],
                        style: TextStyle(
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
        key: _listenerKey,
        onVerticalDragUpdate: (d) {
          MainOnDrag(d.globalPosition.dx, d.globalPosition.dy);
          globalSetState();
        },
        child: Container(
          width: width,
          height: height,
          child: Text(""),
        )));

    Widget? focusWidget;
    Widget tmpWidget;
    for (var i = 0; i < _nrPlayers; i++) {
      for (var j = 0; j < _totalFields; j++) {
        tmpWidget = new AnimatedBuilder(
            animation: animationBoardEffect._cellAnimationControllers[i][j],
            builder: (BuildContext context, Widget? widget) {
              return Positioned(
                //key: _cellKeys[i + 1][j],
                left: _boardXPos[i + 1][j] + _boardXAnimationPos[i + 1][j],
                top: _boardYPos[i + 1][j] + _boardYAnimationPos[i + 1][j],
                child: GestureDetector(
                    onTap: () {
                      CellClick(i, j);
                      globalSetState();
                    },
                    child: Container(
                        width: _boardWidth[i + 1][j],
                        height: _boardHeight[i + 1][j],
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: _colors[i + 1][j],
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(_text[i + 1][j],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ))),
              );
            });
        if (_focusStatus[i][j] == 1) {
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
