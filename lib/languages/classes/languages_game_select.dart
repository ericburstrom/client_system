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

  String get GameTypeOrdinary => GetText(_gameTypeOrdinary);

  String get GameTypeMini => GetText(_gameTypeMini);

  String get GameTypeMaxi => GetText(_gameTypeMaxi);

  String get ChoseUnity => GetText(_choseUnity);

  String get Settings => GetText(_settings);

  String get Game => GetText(_game);

  String get General => GetText(_general);

  String get ColorChangeOverlay => GetText(_colorChangeOverlay);

  String get ChoseLanguage => GetText(_choseLanguage);

  String get StartGame => GetText(_startGame);

  String get Transparency => GetText(_transparency);

  String get LightMotion => GetText(_lightMotion);

  String get Red => GetText(_red);

  String get Green => GetText(_green);

  String get Blue => GetText(_blue);

  String get Appearance => GetText(_appearance);

  String get Misc => GetText(_misc);

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
