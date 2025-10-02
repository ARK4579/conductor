import 'package:conductor/conductor.dart';

class LanguageNotifier extends Notifier<Language> {
  @override
  Language build() => Language.english;

  void urdu() {
    state = Language.urdu;
  }

  void english() {
    state = Language.english;
  }

  void romanUrdu() {
    state = Language.romanUrdu;
  }

  void updateLang(Language language) {
    state = language;
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, Language>(() {
  return LanguageNotifier();
});
