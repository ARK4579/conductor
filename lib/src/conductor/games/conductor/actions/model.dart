// import 'package:conductor/conductor.dart';

// class ItemSelectedAction<T extends ModelBase> extends CAction {
//   final T? item;

//   ItemSelectedAction({required this.item});

//   @override
//   List<CTransition> get transitions => [
//         ItemSelectedTransition(triggererAction: this),
//       ];
// }

// class UpdateIfSelectedAction<T extends ModelBase> extends CAction {
//   final T? item;

//   UpdateIfSelectedAction({required this.item});

//   @override
//   List<CTransition> get transitions => [
//         UpdateIfSelectedTransition(triggererAction: this),
//       ];
// }

// class NewItemAction<T extends ModelBase> extends CAction {
//   @override
//   List<CTransition> get transitions => [
//         NewItemTransition(triggererAction: this),
//       ];
// }

// class CreateItemAction<T extends ModelBase> extends CAction {
//   final T? item;
//   final bool refreshBeforeAdding;
//   final String? existingId;

//   CreateItemAction({
//     required this.item,
//     this.refreshBeforeAdding = false,
//     this.existingId,
//   });

//   @override
//   List<CTransition> get transitions => [
//         CreateItemTransition(triggererAction: this),
//       ];
// }

// class UpdateItemAction<T extends ModelBase> extends CAction {
//   final T? item;

//   UpdateItemAction({
//     required this.item,
//   });

//   @override
//   List<CTransition> get transitions => [
//         UpdateItemTransition(triggererAction: this),
//       ];
// }

// class DeleteItemAction<T extends ModelBase> extends CAction {
//   final T? item;

//   DeleteItemAction({
//     required this.item,
//   });

//   @override
//   List<CTransition> get transitions => [
//         DeleteItemTransition(triggererAction: this),
//       ];
// }

// class RefreshItemAction<T extends ModelBase> extends CAction {
//   final T? item;

//   RefreshItemAction({
//     required this.item,
//   });

//   @override
//   List<CTransition> get transitions => [
//         RefreshItemTransition(triggererAction: this),
//       ];
// }
