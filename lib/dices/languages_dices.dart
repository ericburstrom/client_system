part of '../main.dart';

class LanguagesDices extends Languages {
  final _hold = {'English': 'HOLD'};

  String get Hold_ => GetText(_hold);

  @override
  void LanguagesSetup() {
    _hold['Swedish'] = 'HÅLL';
  }
}
