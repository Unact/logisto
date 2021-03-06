part of 'database.dart';

@DriftAccessor(
  tables: [OrderStorages],
)
class OrderStoragesDao extends DatabaseAccessor<AppStorage> with _$OrderStoragesDaoMixin {
  OrderStoragesDao(AppStorage db) : super(db);

  Future<List<OrderStorage>> getOrderStorages() async {
    return (select(orderStorages)..orderBy([(u) => OrderingTerm(expression: u.sequenceNumber)])).get();
  }

  Future<void> addOrderStorage(OrderStorage orderStorage) async {
    await into(orderStorages).insert(orderStorage, mode: InsertMode.insertOrReplace);
  }

  Future<void> loadOrderStorages(List<OrderStorage> orderStorageList) async {
    await batch((batch) {
      batch.deleteWhere(orderStorages, (row) => const Constant(true));
      batch.insertAll(orderStorages, orderStorageList);
    });
  }

  Future<OrderStorage?> getOrderStorageById(int id) async {
    return await (select(orderStorages)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
