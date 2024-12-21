import 'package:conductor/conductor.dart';

class ItemSelectedTransition<T extends ModelBase> extends CTransition {
  final ItemSelectedAction<T> triggererAction;
  ItemSelectedTransition({required this.triggererAction});

  @override
  void subTransit() async {
    ConductorArenaC.datasets[T]?.selected = triggererAction.item;
  }
}

class UpdateIfSelectedTransition<T extends ModelBase> extends CTransition {
  final UpdateIfSelectedAction<T> triggererAction;
  UpdateIfSelectedTransition({required this.triggererAction});

  @override
  void subTransit() async {
    T? currentSelectedItem = ConductorArenaC.datasets[T]?.selected as T?;
    if (currentSelectedItem?.id == triggererAction.item?.id) {
      ConductorArenaC.datasets[T]?.selected = triggererAction.item;
    }
  }
}

class NewItemTransition<T extends ModelBase> extends CTransition {
  final NewItemAction<T> triggererAction;
  NewItemTransition({required this.triggererAction});

  @override
  void subTransit() {
    T? newItem = ConductorArenaC.getNewItem<T>();
    ConductorArenaC.datasets[T]?.selected = newItem;
  }
}

class CreateItemTransition<T extends ModelBase> extends CTransition {
  final CreateItemAction<T> triggererAction;
  CreateItemTransition({required this.triggererAction});

  @override
  Future<void> subTransitAsync() async {
    T? createdItem = triggererAction.item;
    if (createdItem == null) return;
    if (createdItem.id != null) return;
    if (triggererAction.refreshBeforeAdding) {
      createdItem = await createdItem.refresh() as T;
    }
    T? createdSavedItem;
    if (ConductorArenaC.datasets[T]?.linkLocalDB ?? false) {
      createdSavedItem = await ConductorArenaC.appDataBase?.add<T>(createdItem, existingId: triggererAction.existingId);
    } else {
      createdSavedItem = createdItem;
      if (createdSavedItem.id == null) createdSavedItem = createdSavedItem.copyWithId();
    }
    if (createdSavedItem != null) ConductorArenaC.datasets[T]?.update(createdSavedItem);
    anyAdditionalActions.add(ItemSelectedAction(item: createdSavedItem));
  }
}

class UpdateItemTransition<T extends ModelBase> extends CTransition {
  final UpdateItemAction<T> triggererAction;
  UpdateItemTransition({required this.triggererAction});

  @override
  Future<void> subTransitAsync() async {
    final updatedItem = triggererAction.item;
    if (updatedItem == null) return;
    if (updatedItem.id == null) return;
    final updatedSavedItem =
        (ConductorArenaC.datasets[T]?.linkLocalDB ?? false) ? await ConductorArenaC.appDataBase?.update<T>(updatedItem) : updatedItem;
    if (updatedSavedItem != null) {
      if (updatedSavedItem.isSingleton) {
        ConductorArenaC.singaltonDatasets[T]?.item = updatedSavedItem;
      } else {
        ConductorArenaC.datasets[T]?.update(updatedSavedItem);
      }
    }
    anyAdditionalActions.add(UpdateIfSelectedAction<T>(item: updatedSavedItem));
  }
}

class DeleteItemTransition<T extends ModelBase> extends CTransition {
  final DeleteItemAction<T> triggererAction;
  DeleteItemTransition({required this.triggererAction});

  @override
  Future<void> subTransitAsync() async {
    final deletedItem = triggererAction.item;
    if (deletedItem == null) return;
    if (ConductorArenaC.datasets[T]?.linkLocalDB ?? false) ConductorArenaC.appDataBase?.delete<T>(deletedItem);
    ConductorArenaC.datasets[T]?.delete(deletedItem);
    ConductorArenaC.datasets[T]?.removeSelected(deletedItem);
    final lastSelected = ConductorArenaC.datasets[T]?.lastSelected as T?;
    anyAdditionalActions.add(ItemSelectedAction<T>(item: lastSelected));
  }
}

class RefreshItemTransition<T extends ModelBase> extends CTransition {
  final RefreshItemAction<T> triggererAction;
  RefreshItemTransition({required this.triggererAction});

  @override
  Future<void> subTransitAsync() async {
    final originalItem = triggererAction.item;
    if (originalItem == null) return;
    final refreshedItem = await originalItem.refresh();

    if (originalItem.isDiff(refreshedItem)) {
      anyAdditionalActions.add(UpdateItemAction<T>(item: refreshedItem as T?));
    }
  }
}
