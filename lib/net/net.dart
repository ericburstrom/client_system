part of '../main.dart';

class Net {
  late Socket SocketConnection;

  SendDices(var dices) {
    SocketConnection.emit(
      "sendDices",
      {
        "id": SocketConnection.id,
        "diceValue": dices,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  SendSelection(var player, var cell, var dices) {
    SocketConnection.emit(
      "sendSelection",
      {
        "id": SocketConnection.id,
        "player": player,
        "cell": cell,
        "diceValue": dices,
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

  void onRequestGame(var data) {
    // id: [array connected id's]
    // gameType: 'Ordinary', 'Mini', 'Maxi'
    // nrPlayers: integer
    // connected: same as number of id's
    // gameId: integer
    print('onRequestGame');
    data = Map<String, dynamic>.from(data);
    print(data);

    var gameId = data['gameId'];
    //var foundGame = false;
    print(gameId);
    //print(gameRequest.GameList.length);
    //print(gameRequest.GameList);
    //for (var i = 0; i < gameRequest.GameList.length; i++) {
    //print("is game");
    //print(gameRequest.GameList[i]['gameId']);
    //if (gameRequest.GameList[i]['gameId'] == gameId) {
    //foundGame = true;
    //gameRequest.GameList[i] = data;
    // Update game
    // If full number of players, remove from list and start game
    print(data['nrPlayers']);
    print(data['connected']);

    if (data['nrPlayers'] == data['connected']) {
      // Player to move (MyPlayerId) is connect.id position in array
      var index = data['id'].indexOf(SocketConnection.id);
      print(SocketConnection.id);
      print(index);
      //gameRequest.GameList.removeAt(i);
      if (index != null) {
        // Player is part of game
        application.MyPlayerId = index;
        print("start game");
        gameRequest.StartGame(data['gameType'], data['nrPlayers']);
      }
      //}
      //}
    }
    // if (foundGame == false) {
    //   print(gameRequest.GameList);
    //   gameRequest.GameList = [gameRequest.GameList, data];
    //   print(gameRequest.GameList);
    // }
  }

  // handleSetPlayerNr(var data) {
  //   print('handlesetplayernr');
  //   print(data['playerNr']);
  //   game.MyPlayerId = data['playerNr'];
  // }
  //
  // void handleStartGame(var data) {
  //   print('HandleStartGame');
  //   game.GameDices.startDices();
  //   if (game.MyPlayerId == 0) {
  //     print('I start game!');
  //     game.GameDices.startDices();
  //   }
  // }

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
