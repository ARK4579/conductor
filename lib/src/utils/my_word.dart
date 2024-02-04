import 'package:conductor/conductor.dart';

class MyWord {
  final String englishWord;
  final String? romanUrduWord;
  final String? urduWord;
  const MyWord({
    required this.englishWord,
    this.romanUrduWord,
    this.urduWord,
  });

  String translation(Language language) {
    String translation = englishWord;
    switch (language) {
      case Language.english:
        translation = englishWord;
        break;
      case Language.romanUrdu:
        translation = romanUrduWord ?? translation;
        break;
      case Language.urdu:
        translation = urduWord ?? translation;
        break;
    }
    return translation;
  }
}
