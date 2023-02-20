part of 'database.dart';

@DriftAccessor(
  tables: [Storages],
)
class StoragesDao extends DatabaseAccessor<AppDataStore> with _$StoragesDaoMixin {
  StoragesDao(AppDataStore db) : super(db);

  Future<List<Storage>> getStorages() async {
    return (select(storages)..orderBy([(u) => OrderingTerm(expression: u.sequenceNumber)])).get();
  }

  Future<void> addStorage(Storage storage) async {
    await into(storages).insert(storage, mode: InsertMode.insertOrReplace);
  }

  Future<void> loadStorages(List<Storage> storageList) async {
    await batch((batch) {
      batch.deleteWhere(storages, (row) => const Constant(true));
      batch.insertAll(storages, storageList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<Storage?> getStorageById(int id) async {
    return await (select(storages)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
