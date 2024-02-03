import 'package:conductor/conductor.dart';

class MyWordWidget extends ConsumerWidget {
  final MyWord word;
  const MyWordWidget({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return Text(word.translation(language));
  }
}
