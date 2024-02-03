import 'package:conductor/conductor.dart';

class CounterActionButton extends StatelessWidget {
  final CAction action;
  final MyWord word;
  const CounterActionButton({
    required this.action,
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Dataset.addAction(action);
      },
      child: MyWordWidget(word: word),
    );
  }
}
