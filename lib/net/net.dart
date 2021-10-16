part of '../main.dart';

class Net {
  late Socket SocketConnection;

  SendDices(List<int> dices, int gameId, List<dynamic> playerIds) {
    SocketConnection.emit(
      "sendDices",
      {
        "id": playerIds,
        "diceValue": dices,
        "gameId": gameId,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendSelection(int player, int cell, List<int> dices, int gameId,
      List<dynamic> playersIds) {
    SocketConnection.emit(
      "sendSelection",
      {
        "id": playersIds,
        "player": player,
        "cell": cell,
        "diceValue": dices,
        "gameId": gameId,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendRequestGame(String gameType, int nrPlayers) {
    SocketConnection.emit(
      "sendRequestGame",
      {
        "id": [SocketConnection.id],
        "gameType": gameType,
        "nrPlayers": nrPlayers,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendJoinGame(var gameID) {
    SocketConnection.emit(
      "sendJoinGame",
      {
        "id": SocketConnection.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendJoinedGameOK(var gameID) {
    SocketConnection.emit(
      "sendJoinedGameOK",
      {
        "id": SocketConnection.id,
        "gameID": gameID,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Listen to all message events from connected users
  void onSelection(var data) {
    print('selection');
    print(data);
    if (data['id'] != SocketConnection.id) {
      print('Got Selection');
      application.GameDices.DiceValue = data['diceValue'].cast<int>();
      application.GameDices.UpdateDiceValues();
      application.CalcNewSums(data['player'], data['cell']);
      globalSetState();
    }
  }

  void onDices(var data) {
    print("onDices");
    print(data['diceValue']);
    application.GameDices.MakeDiceRoll(data['diceValue'].cast<int>());
    application.UpdateDiceValues();
    application.GameDices.UpdateDiceImages();
    globalSetState();
  }

  void onJoinGame(var data) {
    // Send join request affirmation
    //sendJoinedGameOK(data['gameID']);
    // Start game
  }

  void onGameStart(var data) {
    print('onGameStart');
    data = Map<String, dynamic>.from(data);
    print(data);
    application.MyPlayerId = data['id'].indexOf(SocketConnection.id);
    application.GameId = data['gameId'];
    application.PlayerIds = data['id'];
    print("start game");
    gameRequest.StartGame(data['gameType'], data['nrPlayers']);
  }

  void onRequestGame(var data) {
    print('onRequestGame');

    print(data);
  }

  void ConnectToServer() {
    try {
      // Configure socket transports must be sepecified
      SocketConnection = io(localhostIO, <String, dynamic>{
        'transports': ['websocket'],
      });

      print('was here...');
      // Handle socket events
      SocketConnection.on('onSelection', onSelection);
      SocketConnection.on('onDices', onDices);
      SocketConnection.on('onRequestGame', onRequestGame);
      SocketConnection.on('onGameStart', onGameStart);
      SocketConnection.on('onJoinGame', onJoinGame);
      //socket.on('StartGame', handleStartGame);
      //socket.on('setPlayerNr', handleSetPlayerNr);
      SocketConnection.on(
          'connect', (_) => print('connect: ${SocketConnection.id}'));
      SocketConnection.on('disconnect', (_) => print('disconnect'));
      SocketConnection.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    SocketConnection.emit("typing", {
      "id": SocketConnection.id,
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
        });

    return response;
  }

  Future mainMakeUpdateHighscores(name, score) async {
    var response = await post(Uri.parse(localhost + '/updateHighscores'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'serverName': name,
          'serverScore': score.toString()
          //'Authorization': authenticate.Jwt
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
