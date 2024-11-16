// import 'package:conductor/conductor.dart';

// class ItemSelectedTransition<T extends ModelBase> extends CTransition {
//   final ItemSelectedAction<T> triggererAction;
//   ItemSelectedTransition({required this.triggererAction});

//   @override
//   void subTransit() async {
//     CalendarDataset().datasets[T]?.selected = triggererAction.item;
//   }
// }

// class UpdateIfSelectedTransition<T extends ModelBase> extends CTransition {
//   final UpdateIfSelectedAction<T> triggererAction;
//   UpdateIfSelectedTransition({required this.triggererAction});

//   @override
//   void subTransit() async {
//     T? currentSelectedItem = CalendarDataset().datasets[T]?.selected as T?;
//     if (currentSelectedItem?.id == triggererAction.item?.id) {
//       CalendarDataset().datasets[T]?.selected = triggererAction.item;
//     }
//   }
// }

// class NewItemTransition<T extends ModelBase> extends CTransition {
//   final NewItemAction<T> triggererAction;
//   NewItemTransition({required this.triggererAction});

//   @override
//   void subTransit() {
//     T? newItem = getNewItem<T>();
//     CalendarDataset().datasets[T]?.selected = newItem;
//   }
// }

// class CreateItemTransition<T extends ModelBase> extends CTransition {
//   final CreateItemAction<T> triggererAction;
//   CreateItemTransition({required this.triggererAction});

//   @override
//   Future<void> subTransitAsync() async {
//     T? createdItem = triggererAction.item;
//     if (createdItem == null) return;
//     if (createdItem.id != null) return;
//     if (triggererAction.refreshBeforeAdding) {
//       createdItem = await createdItem.refresh() as T;
//     }
//     final createdSavedItem = await DataBaseC().add<T>(
//       createdItem,
//       existingId: triggererAction.existingId,
//     );
//     if (createdSavedItem != null) CalendarDataset().datasets[T]?.update(createdSavedItem);
//     anyAdditionalActions.add(ItemSelectedAction(item: createdSavedItem));
//   }
// }

// class UpdateItemTransition<T extends ModelBase> extends CTransition {
//   final UpdateItemAction<T> triggererAction;
//   UpdateItemTransition({required this.triggererAction});

//   @override
//   Future<void> subTransitAsync() async {
//     final updatedItem = triggererAction.item;
//     if (updatedItem == null) return;
//     if (updatedItem.id == null) return;
//     final updatedSavedItem = await DataBaseC().update<T>(updatedItem);
//     if (updatedSavedItem != null) {
//       if (updatedSavedItem.isSingleton) {
//         CalendarDataset().singaltonDatasets[T]?.item = updatedSavedItem;
//       } else {
//         CalendarDataset().datasets[T]?.update(updatedSavedItem);
//       }
//     }
//     anyAdditionalActions.add(UpdateIfSelectedAction<T>(item: updatedSavedItem));
//   }
// }

// class DeleteItemTransition<T extends ModelBase> extends CTransition {
//   final DeleteItemAction<T> triggererAction;
//   DeleteItemTransition({required this.triggererAction});

//   @override
//   Future<void> subTransitAsync() async {
//     final deletedItem = triggererAction.item;
//     if (deletedItem == null) return;
//     DataBaseC().delete<T>(deletedItem);
//     CalendarDataset().datasets[T]?.delete(deletedItem);
//     CalendarDataset().datasets[T]?.removeSelected(deletedItem);
//     final lastSelected = CalendarDataset().datasets[T]?.lastSelected as T?;
//     anyAdditionalActions.add(ItemSelectedAction<T>(item: lastSelected));
//   }
// }

// class RefreshItemTransition<T extends ModelBase> extends CTransition {
//   final RefreshItemAction<T> triggererAction;
//   RefreshItemTransition({required this.triggererAction});

//   @override
//   Future<void> subTransitAsync() async {
//     final originalItem = triggererAction.item;
//     if (originalItem == null) return;
//     final refreshedItem = await originalItem.refresh();

//     if (originalItem.isDiff(refreshedItem)) {
//       anyAdditionalActions.add(UpdateItemAction<T>(item: refreshedItem as T?));
//     }
//   }
// }
