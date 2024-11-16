import 'package:conductor/conductor.dart';

bool isDiffModelBaseItem<T extends ModelBase>(T? item1, T? item2) {
  if (item1 == null && item2 == null) {
    return false;
  }
  if (item1 == null && item2 != null) {
    return true;
  }
  if (item1 != null && item2 == null) {
    return true;
  }
  return item1!.isDiff(item2);
}

bool isDiffModelBaseItems<T extends ModelBase>(List<T>? list1, List<T>? list2) {
  if (list1 == null && list2 == null) {
    return false;
  }
  if (list1?.length == list2?.length) {
    for (var i = 0; i < list1!.length; i++) {
      if (list1[i].isDiff(list2![i])) {
        return true;
      }
    }
    return false;
  }
  // either one or the lists is empty and other isn't or the lengths are different
  return true;
}

abstract class ModelBase {
  String get classTableName => throw Exception('classTableName');

  static const String idKey = '.1';
  static const String timedAtKey = '.2';
  static const String isDeletedKey = '.3';

  final String? id;
  final DateTime? timedAt;
  final bool? isDeleted;

  const ModelBase({
    this.id,
    this.timedAt,
    this.isDeleted,
  });

  ModelBase.fromJson(Map<String, dynamic> json)
      : id = json[ModelBase.idKey],
        timedAt = json[ModelBase.timedAtKey] != null ? DateTime.parse(json[ModelBase.timedAtKey]) : null,
        isDeleted = json[ModelBase.isDeletedKey];

  dynamic copyWith();
  void updateValue();
  dynamic copyWithId({String? newId});
  dynamic copyWithJson(Map<String, dynamic> newJson);

  T copyWithModelBase<T extends ModelBase>({String? id, DateTime? timedAt, bool? isDeleted}) {
    T? item = ConductorArenaC.getNewItemFromJson<T>({
      ...toJson(),
      ModelBase.idKey: id ?? this.id ?? const Uuid().v4(),
      ModelBase.timedAtKey: timedAt?.toIso8601String() ?? this.timedAt?.toIso8601String(),
      ModelBase.isDeletedKey: isDeleted ?? this.isDeleted,
    });

    if (item == null) {
      throw Exception('copyWithModelBase: $T');
    }

    return item;
  }

  dynamic property(String key) => toJson()[key];

  bool get isSingleton => false;

  Map<String, dynamic> toJson() {
    return {
      ModelBase.idKey: id,
      ModelBase.timedAtKey: timedAt?.toIso8601String(),
      ModelBase.isDeletedKey: isDeleted,
    };
  }

  Future<ModelBase?> refresh();

  Future<dynamic> freshFromDB();

  bool isDiff(covariant ModelBase? other);

  int sort(covariant ModelBase? other);
}
