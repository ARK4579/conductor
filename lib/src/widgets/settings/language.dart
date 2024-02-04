import 'package:conductor/conductor.dart';

class LanguageItem extends ConsumerWidget {
  final Language language;
  const LanguageItem({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return InkWell(
      onTap: () {
        ref.read(languageProvider.notifier).updateLang(language);
      },
      child: Text(
        "$currentLanguage->$language",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class LanguageSelectorWidget extends ConsumerWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items =
        Language.values.map((i) => LanguageItem(language: i)).toList();
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: item,
          subtitle: const SizedBox.shrink(),
        );
      },
    );
  }
}
