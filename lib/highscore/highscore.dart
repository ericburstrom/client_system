part of '../main.dart';

class Highscore extends LanguagesHighscore with AnimationsHighscore {
  Highscore() {
    SetupAnimation();
    LoadHighscoresFromFile();
    //loadHighscoresFromServer();
  }

  ///// Internal variables
  var HighscoreText = List.filled(10, "Yatzy", growable: true);
  var HighscoreValue = List.filled(10, 200, growable: true);

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
        await fileHandler.SaveFile(serverBody, fileHandler.FileHighscores);
      } else {
        print('Error getting highscores1');
      }
    } catch (e) {
      print('Error getting highscores2');
    }
  }

  Future LoadHighscoresFromFile() async {
    try {
      var highscores = await fileHandler.ReadFile(fileHandler.FileHighscores);
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
        fileHandler.SaveFile(serverBody, fileHandler.FileHighscores);
      } else {
        print('Error getting highscores');
      }
    } catch (e) {
      print('Error getting highscores onUpdate');
    }
  }

  void SetHighscores(List<dynamic> highscores) {
    for (var i = 0; i < highscores.length; i++) {
      HighscoreText[i] = highscores[i]['name'];
      HighscoreValue[i] = highscores[i]['score'];
    }
  }
}
