part of '../main.dart';

class Languages {
  Languages() {
    LanguagesSetup();
  }

  static var ChosenLanguage = ['Swedish'];
  static var StandardLanguage = 'English';

  static var DifferentLanguages = ['English', 'Swedish'];

  void LanguagesSetup() {}

  List<String> GetLanguages() {
    List<String> translatedLanguages = [];

    return translatedLanguages;
  }

  String GetText(var textVariable) {
    var text = textVariable[ChosenLanguage[0]];
    if (text != null) {
      return text;
    } else {
      return textVariable[StandardLanguage]!;
    }
  }
}
