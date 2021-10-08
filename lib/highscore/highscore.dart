part of '../main.dart';

class Highscore extends LanguagesHighscore {
  Highscore() {
    LoadHighscoresFromFile();
    //loadHighscoresFromServer();
  }

  ///// Internal variables
  var _highscoreText = List.filled(10, "Yatzy", growable: true);
  var _highscoreValue = List.filled(10, 200, growable: true);

  Future LoadAndUpdateHighscoresFromServer() async {
    //List<dynamic> serverResponse;
    var serverResponse;
    try {
      serverResponse = await net.mainMakeGetHighscores();
      if (serverResponse.statusCode == 200) {
        var serverBody = jsonDecode(serverResponse.body);
        SetHighscores(serverBody);
        globalSetState();
        print('Highscores loaded from server');
        await fileHandler.saveFile(serverBody, fileHandler._highscores);
      } else {
        print('Error getting highscores1');
      }
    } catch (e) {
      print('Error getting highscores2');
    }
  }

  Future LoadHighscoresFromFile() async {
    try {
      var highscores = await fileHandler.ReadFile(fileHandler._highscores);
      print("highscores loaded from file");
      SetHighscores(highscores);
    } catch (e) {
      print("Cannot load highscorefile");
    }
  }

  Future Update(String name, int score) async {
    //List<dynamic> serverResponse;
    var serverResponse;
    try {
      serverResponse = await net.mainMakeUpdateHighscores(name, score);
      if (serverResponse.statusCode == 200) {
        var serverBody = jsonDecode(serverResponse.body);
        SetHighscores(serverBody);
        globalSetState();
        fileHandler.saveFile(serverBody, fileHandler._highscores);
      } else {
        print('Error getting highscores');
      }
    } catch (e) {
      print('Error getting highscores onUpdate');
    }
  }

  void SetHighscores(List<dynamic> highscores) {
    for (var i = 0; i < highscores.length; i++) {
      _highscoreText[i] = highscores[i]['name'];
      _highscoreValue[i] = highscores[i]['score'];
    }
  }
}