import 'package:conductor/conductor.dart';

abstract class FirebaseRemoteDBC extends RemoteDBC {
  String getTableName<T extends ModelBase>();
  T getDataBaseC<T extends DataBaseC>();
  T? getNewItemFromJson<T extends ModelBase>(Map<String, dynamic> json);

  User? get currentUser;

  FirebaseFirestore get _remoteDB => FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>>? get _usersCollectionRef {
    User? user = currentUser;
    return user != null ? _remoteDB.collection("users").doc(user.uid) : null;
  }

  Future<void> remoteSyncModel<T extends ModelBase>() async {
    String tableName = getTableName<T>();

    mLog("Remote Syncing $tableName...");
    List<T> items = await getDataBaseC().getAll<T>() ?? [];
    List<String> itemIds = [];
    mLog("pushing ${items.length} ${T}s...");
    for (var item in items) {
      String? itemId = item.id;
      if (itemId == null) continue;
      mLog("Syncing $T $itemId...");
      itemIds.add(itemId);
      try {
        await _usersCollectionRef?.collection(tableName).doc(itemId).set(item.toJson()).timeout(const Duration(seconds: 3));
      } catch (e) {
        mLog("Error syncing $T $itemId: $e");
      }
    }
    mLog("pulling ${tableName}s...");
    await _usersCollectionRef?.collection(tableName).get().then((value) {
      for (var itemJson in value.docs) {
        String itemJsonId = itemJson.id;
        if (itemIds.contains(itemJsonId)) continue;
        mLog("Remote event $itemJsonId...");
        final T? newItem = getNewItemFromJson<T>(itemJson.data());
        if (newItem == null) {
          mLog("Error getting new item from json");
          continue;
        }
        getDataBaseC().add<T>(newItem, existingId: itemJsonId);
      }
    });
    mLog("Remote $T Synced.");
  }
}
