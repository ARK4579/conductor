import 'package:conductor/conductor.dart';

abstract class SembastDataBaseC extends LocalDataBaseC {
  String get directory;
  String get _dbKey => '$directory.db';
  String get singletonObjectID;
  T getNewItem<T extends ModelBase>();
  T? getNewItemFromJson<T extends ModelBase>(Map<String, Object?>? json);
  ModelDataset<T>? getDataset<T extends ModelBase>();
  SingaltonModelDataset<T>? singaltonDatasets<T extends ModelBase>();

  final Map<Type, StoreRef<String, Map<String, Object?>>> _stores = {};
  late final Database _db;

  Future<Database> openDatabaseIo() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await appDocDir.create(recursive: true);
    final path = join(appDocDir.path, _dbKey);
    return await databaseFactoryIo.openDatabase(path, version: 1);
  }

  Future<Database> openDatabaseWeb() async {
    return await databaseFactoryWeb.openDatabase(_dbKey);
  }

  @override
  Future<void> init() async {
    _db = kIsWeb ? await openDatabaseWeb() : await openDatabaseIo();
    initStores();
  }

  void initStores();

  @override
  Future<void> loadDB();

  Future<void> _load<T extends ModelBase>() async {
    final dataset = getDataset<T>();
    if (dataset == null) return;
    dataset.items = await getAll<T>() ?? [];
  }

  Future<void> _loadSingleton<T extends ModelBase>() async {
    final dataset = singaltonDatasets<T>();
    if (dataset == null) return;
    dataset.item = await getSingleton<T>();
  }

  @override
  Future<T?> add<T extends ModelBase>(T item, {String? existingId}) async {
    final saveItem = item.copyWithId(newId: existingId);
    final id = saveItem.id;
    if (id == null) {
      mLog("Can't add $item because id is null");
      return null;
    }
    mLog("Adding $saveItem with id $id");
    final store = _stores[T];
    if (store == null) {
      mLog("Can't add $item because store is null");
      return null;
    }
    final addedJson = await store.record(id).put(_db, saveItem.toJson());
    return getNewItemFromJson<T>(addedJson);
  }

  @override
  Future<T?> update<T extends ModelBase>(T item) async {
    final id = item.id;
    if (id == null) {
      mLog("Can't update $item because id is null");
      return null;
    }
    final store = _stores[T];
    if (store == null) {
      mLog("Can't update $item because store is null");
      return null;
    }
    mLog("Updating $item [$T] with id $id", print: false);
    final updatedJson = await store.record(id).update(_db, item.toJson());
    if (updatedJson == null) {
      mLog("failed to update $item [$T] with id $id");
      return null;
    }
    return getNewItemFromJson<T>(updatedJson);
  }

  @override
  Future<void> delete<T extends ModelBase>(T item) async {
    final id = item.id;
    if (id == null) {
      mLog("Can't delete $item because id is null");
      return;
    }
    final store = _stores[T];
    if (store == null) {
      mLog("Can't update $item because store is null");
      return;
    }
    mLog("Deleting $item with id $id");
    final String? deletedKey = await store.record(id).delete(_db);
    mLog("Deleted key: $deletedKey");
  }

  @override
  Future<T?> getOne<T extends ModelBase>(String? id) async {
    if (id == null) return null;
    final obj = await _stores[T]?.record(id).get(_db);
    return getNewItemFromJson<T>(obj);
  }

  @override
  Future<List<T>?> getAll<T extends ModelBase>() async {
    final store = _stores[T];
    if (store == null) {
      mLog("Can't _getAll because store is null for $T");
      return null;
    }
    final jsonItems = await store.find(_db);
    return jsonItems.map((e) => getNewItemFromJson<T>(e.value)).nonNulls.toList();
  }

  @override
  Future<T> getSingleton<T extends ModelBase>() async {
    T? item = await getOne<T>(singletonObjectID);

    if (item == null) {
      item = getNewItem<T>();
      item = await add<T>(item, existingId: singletonObjectID);
    }

    if (item == null) {
      throw Exception('getSingleton<$T>: unable to get and add');
    }

    return item;
  }
}
