import 'package:conductor/conductor.dart';

abstract class LocalDataBaseC {
  Future<void> init();

  Future<void> loadDB();

  Future<T?> add<T extends ModelBase>(T item, {String? existingId});

  Future<T?> update<T extends ModelBase>(T item);

  Future<void> delete<T extends ModelBase>(T item);

  Future<T> getSingleton<T extends ModelBase>();

  Future<List<T>?> getAll<T extends ModelBase>();

  Future<T?> getOne<T extends ModelBase>(String? id);
}
