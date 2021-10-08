part of '../main.dart';

class Languages {
  Languages() {
    LanguagesSetup();
  }

  static List<String> _chosenLanguage = ['Swedish'];
  static String _standardLanguage = 'English';

  static var _languages = ['English', 'Swedish'];

  void LanguagesSetup() {}

  List<String> GetLanguages() {
    List<String> translatedLanguages = [];

    return translatedLanguages;
  }

  String GetText(var textVariable) {
    var text = textVariable[_chosenLanguage[0]];
    if (text != null) {
      return text;
    } else {
      return textVariable[_standardLanguage]!;
    }
  }
}
