part of '../main.dart';

class LanguagesHighscore extends Languages {
  final _highscores = {'English': 'Highscores'};

  String get Highscores_ => GetText(_highscores);

  @override
  void LanguagesSetup() {
    _highscores['Swedish'] = 'Topplista';
  }
}
