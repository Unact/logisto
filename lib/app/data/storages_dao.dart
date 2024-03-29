part of 'database.dart';

@DriftAccessor(
  tables: [
    Storages,
    StorageCells
  ],
)
class StoragesDao extends DatabaseAccessor<AppDataStore> with _$StoragesDaoMixin {
  StoragesDao(AppDataStore db) : super(db);

  Stream<List<Storage>> watchStorages() {
    return (select(storages)..orderBy([(u) => OrderingTerm(expression: u.sequenceNumber)])).watch();
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

  Future<void> addStorageCell(StorageCell storageCell) async {
    await into(storageCells).insert(storageCell, mode: InsertMode.insertOrReplace);
  }

  Future<StorageCell?> getStorageCellById(int id) async {
    return await (select(storageCells)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
