part of '../main.dart';

class LanguagesHighscore extends Languages {
  var _highscores = {'English': 'Highscores'};

  String get Highscores_ => GetText(_highscores);

  void LanguagesSetup() {
    _highscores['Swedish'] = 'Topplista';
  }
}
