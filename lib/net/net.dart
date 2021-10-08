part of '../main.dart';

class Net {
  late Socket socket;

  SendDices(var dices) {
    socket.emit(
      "sendDices",
      {
        "id": socket.id,
        "diceValue": dices,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendSelection(var player, var cell, var dices) {
    socket.emit(
      "sendSelection",
      {
        "id": socket.id,
        "player": player,
        "cell": cell,
        "diceValue": dices,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendRequestGame(var gameType, var nrPlayers) {
    socket.emit(
      "sendRequestGame",
      {
        "id": socket.id,
        "gameType": gameType,
        "nrPlayers": nrPlayers,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendJoinGame(var gameID) {
    socket.emit(
      "sendJoinGame",
      {
        "id": socket.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendJoinedGameOK(var gameID) {
    socket.emit(
      "sendJoinedGameOK",
      {
        "id": socket.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Listen to all message events from connected users
  void onSelection(var data) {
    print('selection');
    print(data);
    if (data['id'] != socket.id) {
      print('Got Selection');
      application._dices._diceValue = data['diceValue'].cast<int>();
      application._dices._updateDiceValues();
      application.CalcNewSums(data['player'], data['cell']);
      globalSetState();
    }
  }

  void onDices(var data) {
    print(data['diceValue']);
    application._dices.MakeDiceRoll(data['diceValue'].cast<int>());
    application.UpdateDiceValues();
    application._dices.UpdateDiceImages();
    globalSetState();
  }

  void onJoinGame(var data) {
    // Send join request affirmation
    //sendJoinedGameOK(data['gameID']);
    // Start game
  }

  void onRequestGame(var data) {
    print('onRequestGame');
    print(data); // 0 if rejected
    if (data['id'] == socket.id) {
      application._myPlayerId = data['playerId'];
    }
  }

  // handleSetPlayerNr(var data) {
  //   print('handlesetplayernr');
  //   print(data['playerNr']);
  //   game._myPlayerId = data['playerNr'];
  // }
  //
  // void handleStartGame(var data) {
  //   print('HandleStartGame');
  //   game._dices.startDices();
  //   if (game._myPlayerId == 0) {
  //     print('I start game!');
  //     game._dices.startDices();
  //   }
  // }

  void ConnectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io(localhostIO, <String, dynamic>{
        'transports': ['websocket'],
      });

      print('was here...');
      // Handle socket events
      socket.on('onSelection', onSelection);
      socket.on('onDices', onDices);
      socket.on('onRequestGame', onRequestGame);
      socket.on('onJoinGame', onJoinGame);
      //socket.on('StartGame', handleStartGame);
      //socket.on('setPlayerNr', handleSetPlayerNr);
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    socket.emit("typing", {
      "id": socket.id,
      "typing": typing,
    });
  }

  // Listen to update of typing status from connected users
  void handleTyping(var data) {
    print(data);
  }

  // HTTP functions
  Future mainMakeGetHighscores() async {
    var response = await post(Uri.parse(localhost + '/getTopHighscores'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'Authorization': login.jwt}));

    return response;
  }

  Future mainMakeUpdateHighscores(name, score) async {
    var response = await post(Uri.parse(localhost + '/updateHighscores'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverName': name,
          'serverScore': score.toString(),
          'Authorization': login.jwt
        }));

    return response;
  }

  Future mainLogin(String userName, String password) async {
    var response = await post(Uri.parse(localhost + '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverUserName': userName,
          'serverPassword': password,
        }));

    return response;
  }

  Future mainSignup(String userName, String password) async {
    var response = await post(Uri.parse(localhost + '/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverUserName': userName,
          'serverPassword': password,
        }));

    return response;
  }
}
