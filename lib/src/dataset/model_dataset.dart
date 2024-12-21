import 'package:conductor/conductor.dart';

class ItemSelectedSignal<T extends ModelBase> extends Signal {
  @override
  String get name => "ItemSelectedSignal<$T>";
}

class ItemsSignal<T extends ModelBase> extends Signal {
  @override
  String get name => "ItemsSignal<$T>";
}

class ModelSignals<T extends ModelBase> {
  Signal get selected => ItemSelectedSignal<T>();
  Signal get items => ItemsSignal<T>();
}

class ModelDataset<T extends ModelBase> {
  final signals = ModelSignals<T>();

  final bool linkLocalDB;
  ModelDataset({
    this.linkLocalDB = true,
  });

  T? _selected;
  T? get selected => _selected;
  set selected(T? nowSelected) {
    _selected = nowSelected;
    if (nowSelected != null) newSelected(nowSelected);
    DatasetC().setSignal(signals.selected);
  }

  List<T> _items = [];
  List<T> get items => _items;
  set items(List<T> newItems) {
    mLog("ModelDataset: set items: ${T.toString()} ${newItems.length}");
    _items.clear();
    _items.addAll(newItems);
    sort();
    DatasetC().setSignal(signals.items);
  }

  final List<T> _selectedItemsHistory = [];
  T? get lastSelected => _selectedItemsHistory.isNotEmpty ? _selectedItemsHistory.last : null;
  void newSelected(T newSelected) {
    removeSelected(newSelected);
    _selectedItemsHistory.add(newSelected);
  }

  void removeSelected(T item) {
    _selectedItemsHistory.removeWhere((e) => e.id == item.id);
  }

  void sort() {
    _items.sort((a, b) => a.timedAt != null && b.timedAt != null ? a.timedAt!.compareTo(b.timedAt!) : -1);
  }

  void add(T item) {
    _items.add(item);
    DatasetC().setSignal(signals.items);
  }

  void update(T updatedItem) {
    mLog("ModelDataset: update: ${T.toString()} ${updatedItem.id}");
    _items = _items.where((e) => e.id != updatedItem.id).toList();
    _items.add(updatedItem);
    sort();
    DatasetC().setSignal(signals.items);
  }

  void delete(T updatedItem) {
    _items = _items.where((e) => e.id != updatedItem.id).toList();
    DatasetC().setSignal(signals.items);
  }

  void refresh(T item) {
    _items = _items.map((e) => e.id == item.id ? item : e).toList();
    DatasetC().setSignal(signals.items);
  }

  void addMany(List<T> newItems) {
    if (newItems.isEmpty) return;
    for (var item in newItems) {
      _items.add(item);
    }
    sort();
    DatasetC().setSignal(signals.items);
  }

  void remove(T item) {
    if (!_items.contains(item)) return;
    _items.remove(item);
    DatasetC().setSignal(signals.items);
  }

  void clears() {
    if (_items.isEmpty) return;
    _items.clear();
    DatasetC().setSignal(signals.items);
  }
}
