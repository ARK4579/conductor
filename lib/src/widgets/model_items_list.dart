import 'package:conductor/conductor.dart';

class ModelListTile<T extends ModelBase> extends StatelessWidget {
  final T item;
  final bool selected;
  final WidgetCallBackFunction<T> widgetCallback;
  const ModelListTile({
    super.key,
    required this.item,
    required this.selected,
    required this.widgetCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ConductorArenaC.conduct(ItemSelectedAction<T>(item: item));
      },
      // hoverColor: Theme.of(context).colorScheme.secondary,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.secondary : null,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              widgetCallback.call(item),
            ],
          ),
        ),
      ),
    );
  }
}

class ModelList<T extends ModelBase> extends ConsumerWidget {
  final WidgetCallBackFunction<T> widgetCallback;
  const ModelList({
    super.key,
    required this.widgetCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watchSignal(ConductorArenaC.datasets[T]?.signals.items);
    ref.watchSignal(ConductorArenaC.datasets[T]?.signals.selected);
    mLog("ModelList<$T>+++");

    final items = ConductorArenaC.datasets[T]?.items;
    final selectedItem = ConductorArenaC.datasets[T]?.selected;

    List<Widget> slotWidgets = items
            ?.map(
              (tileItem) => ModelListTile<T>(
                item: tileItem as T,
                selected: tileItem.id == selectedItem?.id,
                widgetCallback: widgetCallback,
              ),
            )
            .toList() ??
        [];

    Widget child = Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${items?.length ?? "No"} ${ConductorArenaC.getTableName<T>()}"),
              ),
              ...slotWidgets,
            ],
          ),
        ),
        const Divider(),
        Row(
          children: [
            Expanded(child: Container()),
            if (selectedItem != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    ConductorArenaC.conduct(ItemSelectedAction<T>(item: null));
                  },
                  child: const Icon(Icons.close),
                ),
              ),
          ],
        ),
      ],
    );

    return child;
  }
}
