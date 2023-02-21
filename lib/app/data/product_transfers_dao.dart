part of 'database.dart';

@DriftAccessor(
  tables: [
    Products,
    ProductTransfers,
    ProductTransferFromCells,
    ProductTransferToCells,
    ProductStores
  ],
)
class ProductTransfersDao extends DatabaseAccessor<AppDataStore> with _$ProductTransfersDaoMixin {
  ProductTransfersDao(AppDataStore db) : super(db);

  Future<void> addProductTransfer(ProductTransfersCompanion productTransfer) async {
    await into(productTransfers).insert(productTransfer, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductTransferFromCell(ProductTransferFromCellsCompanion fromCell) async {
    await into(productTransferFromCells).insert(fromCell, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductTransferToCell(ProductTransferToCellsCompanion toCell) async {
    await into(productTransferToCells).insert(toCell, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteProductTransferFromCell(ProductTransferFromCell newCell) async {
    await (delete(productTransferFromCells)..where((e) => e.id.equals(newCell.id))).go();
  }

  Future<void> deleteProductTransferToCell(ProductTransferToCell newCell) async {
    await (delete(productTransferToCells)..where((e) => e.id.equals(newCell.id))).go();
  }

  Future<int> upsertProductTransfer(int id, ProductTransfersCompanion productTransfer) {
    return into(productTransfers).insertOnConflictUpdate(productTransfer);
  }

  Future<void> clearProductTransferToCells() async {
    await delete(productTransferToCells).go();
  }

  Future<void> clearProductTransfers() async {
    await delete(productTransfers).go();
  }

  Future<ProductTransferEx?> getCurrentTransfer() async {
    final storeFrom = alias(productStores, 'storeFrom');
    final storeTo = alias(productStores, 'storeTo');

    final productTransferQuery = select(productTransfers)
      .join([
        leftOuterJoin(storeFrom, storeFrom.id.equalsExp(productTransfers.storeFromId)),
        leftOuterJoin(storeTo, storeTo.id.equalsExp(productTransfers.storeToId))
      ]);
    final productTransferRes = await productTransferQuery.getSingleOrNull();

    if (productTransferRes == null) return null;

    final productTransferFromCellQuery = select(productTransferFromCells)
      .join([
        innerJoin(products, products.id.equalsExp(productTransferFromCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productTransferFromCells.storageCellId))
      ])
      ..where(productTransferFromCells.productTransferId.equals(productTransferRes.readTable(productTransfers).id));
    final productTransferFromCellRes = await productTransferFromCellQuery.get();
    final productTransferToCellQuery = select(productTransferToCells)
      .join([
        innerJoin(products, products.id.equalsExp(productTransferToCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productTransferToCells.storageCellId))
      ])
      ..where(productTransferToCells.productTransferId.equals(productTransferRes.readTable(productTransfers).id));
    final productTransferToCellRes = await productTransferToCellQuery.get();

    return ProductTransferEx(
      productTransferRes.readTable(productTransfers),
      productTransferRes.readTableOrNull(storeFrom),
      productTransferRes.readTableOrNull(storeTo),
      productTransferFromCellRes.map((p0) {
        return ProductTransferFromCellEx(
          p0.readTable(productTransferFromCells),
          p0.readTable(products),
          p0.readTable(storageCells)
        );
      }).toList(),
      productTransferToCellRes.map((p0) {
        return ProductTransferToCellEx(
          p0.readTable(productTransferToCells),
          p0.readTable(products),
          p0.readTable(storageCells)
        );
      }).toList()
    );
  }
}

class ProductTransferEx {
  final ProductTransfer productTransfer;
  final ProductStore? storeFrom;
  final ProductStore? storeTo;
  final List<ProductTransferFromCellEx> fromCells;
  final List<ProductTransferToCellEx> toCells;

  ProductTransferEx(this.productTransfer, this.storeFrom, this.storeTo, this.fromCells, this.toCells);
}

class ProductTransferFromCellEx {
  final ProductTransferFromCell fromCell;
  final Product product;
  final StorageCell storageCell;

  ProductTransferFromCellEx(this.fromCell, this.product, this.storageCell);
}

class ProductTransferToCellEx {
  final ProductTransferToCell toCell;
  final Product product;
  final StorageCell storageCell;

  ProductTransferToCellEx(this.toCell, this.product, this.storageCell);
}
