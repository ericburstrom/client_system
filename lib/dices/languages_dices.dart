part of '../main.dart';

class LanguagesDices extends Languages {
  var _hold = {'English': 'HOLD'};

  String get Hold_ => GetText(_hold);

  void LanguagesSetup() {
    _hold['Swedish'] = 'HÅLL';
  }
}
