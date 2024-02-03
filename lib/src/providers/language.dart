import 'package:conductor/conductor.dart';

// enum Language {
//   english,
//   romanUrdu,
//   urdu,
// }

class LanguageNotifier extends StateNotifier<Language> {
  LanguageNotifier(super.state);

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

final languageProvider =
    StateNotifierProvider<LanguageNotifier, Language>((ref) {
  return LanguageNotifier(Language.romanUrdu);
});
