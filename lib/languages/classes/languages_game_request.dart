part of '../../main.dart';

class LanguagesGameRequest extends Languages {
  var _gameRequest = {'English': 'Game Request'};

  String get GameRequest => GetText(_gameRequest);

  void LanguagesSetup() {
    _gameRequest['Swedish'] = 'Spel Inbjudan';
  }
}
