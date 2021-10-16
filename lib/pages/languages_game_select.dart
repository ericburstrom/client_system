part of '../main.dart';

class LanguagesGameSelect extends Languages {
  final _gameTypeOrdinary = {'English': 'Ordinary'};
  final _gameTypeMini = {'English': 'Mini'};
  final _gameTypeMaxi = {'English': 'Maxi'};
  final _choseUnity = {'English': '3D Dices'};
  final _settings = {'English': 'Settings'};
  final _game = {'English': 'Game'};
  final _general = {'English': 'General'};
  final _colorChangeOverlay = {'English': 'Color Change Overlay'};
  final _choseLanguage = {'English': 'Chose Language'};
  final _startGame = {'English': 'Start Game'};
  final _gameList = {'English': 'Games List'};
  final _transparency = {'English': 'Transparency'};
  final _lightMotion = {'English': 'Light Motion'};
  final _red = {'English': 'Red'};
  final _green = {'English': 'Green'};
  final _blue = {'English': 'Blue'};
  final _appearance = {'English': 'Appearance'};
  final _misc = {'English': 'Misc'};

  String get GameTypeOrdinary_ => GetText(_gameTypeOrdinary);

  String get GameTypeMini_ => GetText(_gameTypeMini);

  String get GameTypeMaxi_ => GetText(_gameTypeMaxi);

  String get ChoseUnity_ => GetText(_choseUnity);

  String get Settings_ => GetText(_settings);

  String get Game_ => GetText(_game);

  String get General_ => GetText(_general);

  String get ColorChangeOverlay_ => GetText(_colorChangeOverlay);

  String get ChoseLanguage_ => GetText(_choseLanguage);

  String get StartGame_ => GetText(_startGame);

  String get GameList_ => GetText(_gameList);

  String get Transparency_ => GetText(_transparency);

  String get LightMotion_ => GetText(_lightMotion);

  String get Red_ => GetText(_red);

  String get Green_ => GetText(_green);

  String get Blue_ => GetText(_blue);

  String get Appearance_ => GetText(_appearance);

  String get Misc_ => GetText(_misc);

  @override
  void LanguagesSetup() {
    _gameTypeOrdinary['Swedish'] = 'Standard';
    _choseUnity['Swedish'] = '3D Tärningar';
    _settings['Swedish'] = 'Inställningar';
    _game['Swedish'] = 'Spel';
    _general['Swedish'] = 'Allmänt';
    _colorChangeOverlay['Swedish'] = 'Färginställningar Live';
    _choseLanguage['Swedish'] = 'Välj Språk';
    _startGame['Swedish'] = 'Starta Spelet';
    _gameList['Swedish'] = 'Spel Lista';
    _transparency['Swedish'] = 'Transparens';
    _lightMotion['Swedish'] = 'Cirkulärt Ljus';
    _red['Swedish'] = 'Röd';
    _green['Swedish'] = 'Grön';
    _blue['Swedish'] = 'Blå';
    _appearance['Swedish'] = 'Utseende';
    _misc['Swedish'] = 'Diverse';
  }
}
