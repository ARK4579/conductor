import 'package:conductor/conductor.dart';

class ItemSignal<T extends ModelBase> extends Signal {
  @override
  String get name => "ItemSignal<$T>";
}

class SingaltonModelSignals<T extends ModelBase> {
  Signal get item => ItemSignal<T>();
}

class SingaltonModelDataset<T extends ModelBase> {
  final signals = SingaltonModelSignals<T>();

  late T _item;
  T get item => _item;
  set item(T newItem) {
    _item = newItem;
    DatasetC().setSignal(signals.item);
  }

  void setInitial(T newItem) {
    _item = newItem;
  }
}
