import 'package:conductor/conductor.dart';

class BaseDataModel {
  final DataConfigFiled? config;

  const BaseDataModel({this.config});

  int? get id => config?.id;
  DateTime? get createdAt => config?.createdAt;
  DateTime? get updatedAt => config?.updatedAt;
}
