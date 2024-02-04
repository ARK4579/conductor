import 'package:conductor/conductor.dart';

final systemSembastDBProvider = FutureProvider<Database>((ref) async {
  String dbPath = "pos.sayana.pk_${CoreValues.systemDbName}.system.db";
  DatabaseFactory? dbFactory;

  if (CoreFlags.isWeb) {
    dbFactory = databaseFactoryWeb;
  } else {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    dbPath = join(dir.path, dbPath);
    dbFactory = databaseFactoryIo;
  }

  return dbFactory.openDatabase(dbPath);
});

final businessSembastDBProvider = FutureProvider<Database?>((ref) async {
  String? dbName = ref.watch(businessDbNameProvider);

  // since we don't know which db to open for current business, we will not open any
  if (dbName == null) return null;

  String dbPath = "pos.sayana.pk_$dbName.business.db";
  DatabaseFactory? dbFactory;

  if (CoreFlags.isWeb) {
    dbFactory = databaseFactoryWeb;
  } else {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    dbPath = join(dir.path, dbPath);
    dbFactory = databaseFactoryIo;
  }

  return dbFactory.openDatabase(dbPath);
});
