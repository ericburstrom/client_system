part of '../main.dart';

class LanguagesGameRequest extends Languages {
  final _gameRequest = {'English': 'Game Request'};

  String get GameRequest_ => GetText(_gameRequest);

  @override
  void LanguagesSetup() {
    _gameRequest['Swedish'] = 'Spel Inbjudan';
  }
}
