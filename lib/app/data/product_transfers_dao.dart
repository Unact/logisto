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

  Stream<ProductTransferEx?> watchCurrentTransfer() {
    final storeFrom = alias(productStores, 'storeFrom');
    final storeTo = alias(productStores, 'storeTo');

    final productTransferStream = select(productTransfers)
      .join([
        leftOuterJoin(storeFrom, storeFrom.id.equalsExp(productTransfers.storeFromId)),
        leftOuterJoin(storeTo, storeTo.id.equalsExp(productTransfers.storeToId))
      ]).watch();
    final productTransferFromCellStream = select(productTransferFromCells)
      .join([
        innerJoin(products, products.id.equalsExp(productTransferFromCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productTransferFromCells.storageCellId)),
        innerJoin(productTransfers, productTransfers.id.equalsExp(productTransferFromCells.productTransferId))
      ]).watch();
    final productTransferToCellStream = select(productTransferToCells)
      .join([
        innerJoin(products, products.id.equalsExp(productTransferToCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productTransferToCells.storageCellId)),
        innerJoin(productTransfers, productTransfers.id.equalsExp(productTransferToCells.productTransferId))
      ]).watch();

    return Rx.combineLatest3(
      productTransferStream,
      productTransferFromCellStream,
      productTransferToCellStream,
      (
        List<TypedResult> productTransferList,
        List<TypedResult> productTransferFromCellList,
        List<TypedResult> productTransferToCellList
      ) {
        final productTransferRes = productTransferList.firstOrNull;

        if (productTransferRes == null) return null;

        final productTransferFromCellRes = productTransferFromCellList.where((e) =>
          e.readTable(productTransferFromCells).productTransferId == productTransferRes.readTable(productTransfers).id
        );
        final productTransferToCellRes = productTransferToCellList.where((e) =>
          e.readTable(productTransferToCells).productTransferId == productTransferRes.readTable(productTransfers).id
        );

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
