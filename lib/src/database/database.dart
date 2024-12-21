import 'package:conductor/conductor.dart';

abstract class DataBaseC {
  LocalDataBaseC? get localDataBaseC;
  RemoteDBC? get remoteDataBaseC;

  Future<void> init() async {
    await localDataBaseC?.init();
  }

  Future<void> remoteSync() async => remoteDataBaseC?.remoteSync();
  Future<void> loadDB() async => localDataBaseC?.loadDB();

  Future<T?> add<T extends ModelBase>(T e, {String? existingId}) async => localDataBaseC?.add<T>(e, existingId: existingId);

  Future<T?> update<T extends ModelBase>(T e) async => localDataBaseC?.update<T>(e);

  Future<void> delete<T extends ModelBase>(T e) async => localDataBaseC?.delete<T>(e);

  Future<T?> getSingleton<T extends ModelBase>() async => localDataBaseC?.getSingleton<T>();

  Future<List<T>?> getAll<T extends ModelBase>() async => localDataBaseC?.getAll<T>();
  Future<T?> getOne<T extends ModelBase>(String? id) async => localDataBaseC?.getOne<T>(id);
}
