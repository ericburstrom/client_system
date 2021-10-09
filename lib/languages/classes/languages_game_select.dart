part of '../../main.dart';

class LanguagesGameSelect extends Languages {
  var _gameTypeOrdinary = {'English': 'Ordinary'};
  var _gameTypeMini = {'English': 'Mini'};
  var _gameTypeMaxi = {'English': 'Maxi'};
  var _choseUnity = {'English': '3D Dices'};
  var _settings = {'English': 'Settings'};
  var _game = {'English': 'Game'};
  var _general = {'English': 'General'};
  var _colorChangeOverlay = {'English': 'Color Change Overlay'};
  var _choseLanguage = {'English': 'Chose Language'};
  var _startGame = {'English': 'Start Game'};
  var _transparency = {'English': 'Transparency'};
  var _lightMotion = {'English': 'Light Motion'};
  var _red = {'English': 'Red'};
  var _green = {'English': 'Green'};
  var _blue = {'English': 'Blue'};
  var _appearance = {'English': 'Appearance'};
  var _misc = {'English': 'Misc'};

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

  String get Transparency_ => GetText(_transparency);

  String get LightMotion_ => GetText(_lightMotion);

  String get Red_ => GetText(_red);

  String get Green_ => GetText(_green);

  String get Blue_ => GetText(_blue);

  String get Appearance_ => GetText(_appearance);

  String get Misc_ => GetText(_misc);

  void LanguagesSetup() {
    _gameTypeOrdinary['Swedish'] = 'Standard';
    _choseUnity['Swedish'] = '3D Tärningar';
    _settings['Swedish'] = 'Inställningar';
    _game['Swedish'] = 'Spel';
    _general['Swedish'] = 'Allmänt';
    _colorChangeOverlay['Swedish'] = 'Färginställningar Live';
    _choseLanguage['Swedish'] = 'Välj Språk';
    _startGame['Swedish'] = 'Starta Spelet';
    _transparency['Swedish'] = 'Transparens';
    _lightMotion['Swedish'] = 'Cirkulärt Ljus';
    _red['Swedish'] = 'Röd';
    _green['Swedish'] = 'Grön';
    _blue['Swedish'] = 'Blå';
    _appearance['Swedish'] = 'Utseende';
    _misc['Swedish'] = 'Diverse';
  }
}
