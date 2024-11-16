import 'package:conductor/conductor.dart';

abstract class FirebaseRemoteDBC extends RemoteDBC {
  User? get currentUser;

  FirebaseFirestore get _remoteDB => FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>>? get _usersCollectionRef {
    User? user = currentUser;
    return user != null ? _remoteDB.collection("users").doc(user.uid) : null;
  }

  Future<void> remoteSyncModel<T extends ModelBase>() async {
    String? tableName = ConductorArenaC.getTableName<T>();
    if (tableName == null) {
      mLog("Error getting table name for $T, skipping remote sync.");
      return;
    }

    mLog("Remote Syncing $tableName...");
    List<T> items = await ConductorArenaC.appDataBase?.getAll<T>() ?? [];
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
        final T? newItem = ConductorArenaC.getNewItemFromJson<T>(itemJson.data());
        if (newItem == null) {
          mLog("Error getting new item from json");
          continue;
        }
        ConductorArenaC.appDataBase?.add<T>(newItem, existingId: itemJsonId);
      }
    });
    mLog("Remote $T Synced.");
  }
}
