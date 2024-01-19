part of 'database.dart';

@DriftAccessor(
  tables: [
    Products,
    ProductArrivals,
    ProductArrivalLines,
    ProductArrivalPackages,
    ProductArrivalUnloadPackages,
    ProductArrivalPackageLines,
    ProductArrivalPackageTypes,
    ProductArrivalPackageNewLines,
    ProductArrivalPackageNewCells,
    ProductArrivalPackageNewCodes,
    ProductArrivalNewPackages,
    ProductArrivalNewUnloadPackages
  ],
)
class ProductArrivalsDao extends DatabaseAccessor<AppDataStore> with _$ProductArrivalsDaoMixin {
  ProductArrivalsDao(AppDataStore db) : super(db);

  Future<void> loadProductArrivals(List<ProductArrival> list) async {
    await batch((batch) {
      batch.deleteWhere(productArrivals, (row) => const Constant(true));
      batch.insertAll(productArrivals, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadProductArrivalLines(List<ProductArrivalLine> lineList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalLines, (row) => const Constant(true));
      batch.insertAll(productArrivalLines, lineList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadProductArrivalPackages(List<ProductArrivalPackage> packageList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackages, (row) => const Constant(true));
      batch.insertAll(productArrivalPackages, packageList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadProductArrivalPackageTypes(List<ProductArrivalPackageType> packageTypeList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackageTypes, (row) => const Constant(true));
      batch.insertAll(productArrivalPackageTypes, packageTypeList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadProductArrivalPackageLines(List<ProductArrivalPackageLine> lineList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackageLines, (row) => const Constant(true));
      batch.insertAll(productArrivalPackageLines, lineList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadProductArrivalUnloadPackages(List<ProductArrivalUnloadPackage> unloadPackageList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalUnloadPackages, (row) => const Constant(true));
      batch.insertAll(productArrivalUnloadPackages, unloadPackageList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> addProductArrivalNewPackage(ProductArrivalNewPackagesCompanion newPackage) async {
    await into(productArrivalNewPackages).insert(newPackage, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductArrivalPackageNewLine(ProductArrivalPackageNewLinesCompanion newLine) async {
    await into(productArrivalPackageNewLines).insert(newLine, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductArrivalPackageNewCell(ProductArrivalPackageNewCellsCompanion newCell) async {
    await into(productArrivalPackageNewCells).insert(newCell, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductArrivalPackageNewCode(ProductArrivalPackageNewCodesCompanion newCode) async {
    await into(productArrivalPackageNewCodes).insert(newCode, mode: InsertMode.insertOrReplace);
  }

  Future<void> addProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackagesCompanion newUnloadPackage) async {
    await into(productArrivalNewUnloadPackages).insert(newUnloadPackage, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteProductArrivalNewPackage(ProductArrivalNewPackage newPackage) async {
    await (delete(productArrivalNewPackages)..where((e) => e.id.equals(newPackage.id))).go();
  }

  Future<void> deleteProductArrivalPackageNewLine(ProductArrivalPackageNewLine newLine) async {
    await (delete(productArrivalPackageNewLines)..where((e) => e.id.equals(newLine.id))).go();
  }

  Future<void> deleteProductArrivalPackageNewCell(ProductArrivalPackageNewCell newCell) async {
    await (delete(productArrivalPackageNewCells)..where((e) => e.id.equals(newCell.id))).go();
  }

  Future<void> deleteProductArrivalPackageNewCode(ProductArrivalPackageNewCode newCode) async {
    await (delete(productArrivalPackageNewCodes)..where((e) => e.id.equals(newCode.id))).go();
  }

  Future<void> deleteProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackage newUnloadPackage) async {
    await (delete(productArrivalNewUnloadPackages)..where((e) => e.id.equals(newUnloadPackage.id))).go();
  }

  Future<int> upsertProductArrival(int id, ProductArrivalsCompanion productArrival) {
    return into(productArrivals).insertOnConflictUpdate(productArrival);
  }

  Future<int> upsertProductArrivalPackage(int id, ProductArrivalPackagesCompanion productArrivalPackage) {
    return into(productArrivalPackages).insertOnConflictUpdate(productArrivalPackage);
  }

  Future<int> upsertProductArrivalPackageLine(int id, ProductArrivalPackageLinesCompanion productArrivalPackageLine) {
    return into(productArrivalPackageLines).insertOnConflictUpdate(productArrivalPackageLine);
  }

  Future<int> upsertProductArrivalUnloadPackage(
    int id,
    ProductArrivalUnloadPackagesCompanion productArrivalUnloadPackage
  ) {
    return into(productArrivalUnloadPackages).insertOnConflictUpdate(productArrivalUnloadPackage);
  }

  Future<void> updateProductArrivalEx(ProductArrivalEx productArrivalEx) async {
    await (delete(productArrivals)..where((tbl) => tbl.id.equals(productArrivalEx.productArrival.id))).go();
    await upsertProductArrival(productArrivalEx.productArrival.id, productArrivalEx.productArrival.toCompanion(false));
    await Future.forEach<ProductArrivalPackageLineEx>(
      productArrivalEx.packages.map((e) => e.packageLines).expand((e) => e),
      (e) => upsertProductArrivalPackageLine(e.line.id, e.line.toCompanion(false))
    );
    await Future.forEach<ProductArrivalPackageEx>(
      productArrivalEx.packages,
      (e) => upsertProductArrivalPackage(e.package.id, e.package.toCompanion(false))
    );
    await Future.forEach<ProductArrivalUnloadPackage>(
      productArrivalEx.unloadPackages,
      (e) => upsertProductArrivalUnloadPackage(e.id, e.toCompanion(false))
    );
  }

  Future<void> clearProductArrivalNewPackages() async {
    await delete(productArrivalNewPackages).go();
  }

  Future<void> clearProductArrivalPackageNewLines() async {
    await delete(productArrivalPackageNewLines).go();
  }

  Future<void> clearProductArrivalPackageNewCells() async {
    await delete(productArrivalPackageNewCells).go();
  }

  Future<void> clearProductArrivalPackageNewCodes() async {
    await delete(productArrivalPackageNewCodes).go();
  }

  Future<void> clearProductArrivalNewUnloadPackages() async {
    await delete(productArrivalNewUnloadPackages).go();
  }

  Stream<List<ProductArrivalPackageType>> watchProductArrivalPackageTypes() {
    return select(productArrivalPackageTypes).watch();
  }

  Stream<List<ProductArrivalNewPackage>> watchProductArrivalNewPackages(int productArrivalId) {
    return (
      select(productArrivalNewPackages)
      ..where((e)=> e.productArrivalId.equals(productArrivalId))
    ).watch();
  }

  Stream<List<ProductArrivalPackageNewLineEx>> watchProductArrivalPackageNewLinesEx(int productArrivalPackageId) {
    final packageNewLinesQuery = select(productArrivalPackageNewLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageNewLines.productId))])
      ..where(productArrivalPackageNewLines.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);

    return packageNewLinesQuery.watch().map((event) => event.map((packageLine) {
      return ProductArrivalPackageNewLineEx(
        packageLine.readTable(productArrivalPackageNewLines),
        packageLine.readTable(products)
      );
    }).toList());
  }

  Stream<List<ProductArrivalPackageNewCellEx>> watchProductArrivalPackageNewCellsEx(int productArrivalPackageId) {
    final packageNewCellsQuery = select(productArrivalPackageNewCells)
      .join([
        innerJoin(products, products.id.equalsExp(productArrivalPackageNewCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productArrivalPackageNewCells.storageCellId))
      ])
      ..where(productArrivalPackageNewCells.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);

    return packageNewCellsQuery.watch().map((event) => event.map((packageCell) {
      return ProductArrivalPackageNewCellEx(
        packageCell.readTable(productArrivalPackageNewCells),
        packageCell.readTable(products),
        packageCell.readTable(storageCells)
      );
    }).toList());
  }

  Stream<List<ProductArrivalPackageNewCodeEx>> watchProductArrivalPackageNewCodesEx(int productArrivalPackageId) {
    final packageNewCodesQuery = select(productArrivalPackageNewCodes)
      .join([
        innerJoin(products, products.id.equalsExp(productArrivalPackageNewCodes.productId)),
      ])
      ..where(productArrivalPackageNewCodes.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);

    return packageNewCodesQuery.watch().map((event) => event.map((packageCode) {
      return ProductArrivalPackageNewCodeEx(
        packageCode.readTable(productArrivalPackageNewCodes),
        packageCode.readTable(products)
      );
    }).toList());
  }

  Stream<List<ProductArrivalNewUnloadPackage>> watchProductArrivalNewUnloadPackages(int productArrivalId) {
    return (
      select(productArrivalNewUnloadPackages)
      ..where((e)=> e.productArrivalId.equals(productArrivalId))
    ).watch();
  }

  Stream<List<ProductArrivalEx>> watchProductPackageExList() {
    final productArrivalsStream = (
      select(productArrivals)
      .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
      ..orderBy([
        OrderingTerm(expression: productArrivals.id),
        OrderingTerm(expression: productArrivals.arrivalDate)
      ])
    ).watch();
    final productArrivalLinesStream = (
      select(productArrivalLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalLines.productId))])
      ..orderBy([OrderingTerm(expression: products.name)])
    ).watch();
    final productArrivalPackagesStream = (
      select(productArrivalPackages)..orderBy([(u) => OrderingTerm(expression: u.id)])
    ).watch();
    final productArrivalUnloadPackagesStream = (
      select(productArrivalUnloadPackages)..orderBy([(u) => OrderingTerm(expression: u.typeName)])
    ).watch();
    final productArrivalPackageLinesStream = (
      select(productArrivalPackageLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
      ..orderBy([OrderingTerm(expression: products.name)])
    ).watch();

    return Rx.combineLatest5(
      productArrivalsStream,
      productArrivalLinesStream,
      productArrivalPackagesStream,
      productArrivalUnloadPackagesStream,
      productArrivalPackageLinesStream,
      (
        productArrivalsRes,
        productArrivalLinesRes,
        productArrivalPackagesRes,
        productArrivalUnloadPackagesRes,
        productArrivalPackageLinesRes
      ) {
        return productArrivalsRes.map((pa) {
          final lines = productArrivalLinesRes
            .where((e) => e.readTable(productArrivalLines).productArrivalId == pa.readTable(productArrivals).id)
            .map((e) => ProductArrivalLineEx(e.readTable(productArrivalLines), e.readTable(products)))
            .toList();
          final packages = productArrivalPackagesRes
            .where((e) => e.productArrivalId == pa.readTable(productArrivals).id)
            .map((e) {
              final packageLinesRows = productArrivalPackageLinesRes
                .where((line) => line.readTable(productArrivalPackageLines).productArrivalPackageId == e.id)
                .map((line) {
                  return ProductArrivalPackageLineEx(
                    line.readTable(productArrivalPackageLines),
                    line.readTable(products)
                  );
                }).toList();

              return ProductArrivalPackageEx(e, packageLinesRows);
            })
            .toList();
          final unloadPackages = productArrivalUnloadPackagesRes
            .where((e) => e.productArrivalId == pa.readTable(productArrivals).id).toList();

          return ProductArrivalEx(
            pa.readTable(productArrivals),
            lines,
            pa.readTable(storages),
            packages,
            unloadPackages
          );
        }).toList();
      }
    );
  }

  Stream<ProductArrivalEx?> watchProductArrivalEx(int id) {
    return _watchProductArrivalEx(productArrivals.id.equals(id));
  }

  Stream<ProductArrivalEx?> watchProductArrivalExByNumber(String number) {
    return _watchProductArrivalEx(productArrivals.number.equals(number));
  }

  Stream<ProductArrivalPackageEx> watchProductArrivalPackageEx(int id) {
    final packageStream = (select(productArrivalPackages)..where((t) => t.id.equals(id))).watchSingle();
    final packageLinesStream = (
      select(productArrivalPackageLines)
        .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
        ..where(productArrivalPackageLines.productArrivalPackageId.equals(id))
        ..orderBy([OrderingTerm(expression: products.name)])
    ).watch();

    return Rx.combineLatest2(
      packageStream,
      packageLinesStream,
      (packageRow, packageLinesRes) {
        final packageLinesRows = packageLinesRes.map((packageLine) {
          return ProductArrivalPackageLineEx(
            packageLine.readTable(productArrivalPackageLines),
            packageLine.readTable(products)
          );
        }).toList();

        return ProductArrivalPackageEx(packageRow, packageLinesRows);
      }
    );
  }

  Stream<ProductArrivalEx?> _watchProductArrivalEx(Expression<bool> whereExp) {
    final productArrivalsIdQuery = selectOnly(productArrivals)
      ..addColumns([productArrivals.id])
      ..where(whereExp);
    final productArrivalUnloadPackagesIdQuery = selectOnly(productArrivalUnloadPackages)
      ..addColumns([productArrivalUnloadPackages.id])
      ..where(productArrivalUnloadPackages.productArrivalId.isInQuery(productArrivalsIdQuery));

    final productArrivalsStream = (
      select(productArrivals)
        .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
        ..orderBy([
          OrderingTerm(expression: productArrivals.id),
          OrderingTerm(expression: productArrivals.arrivalDate)
        ])
        ..where(whereExp)
    ).watch();
    final productArrivalLinesStream = (
      select(productArrivalLines)
        .join([innerJoin(products, products.id.equalsExp(productArrivalLines.productId))])
        ..where(productArrivalLines.productArrivalId.isInQuery(productArrivalsIdQuery))
        ..orderBy([OrderingTerm(expression: products.name)])
    ).watch();
    final productArrivalPackagesStream = (
      select(productArrivalPackages)
        ..where((t) => t.productArrivalId.isInQuery(productArrivalsIdQuery))
        ..orderBy([(u) => OrderingTerm(expression: u.id)])
    ).watch();
    final productArrivalUnloadPackagesStream = (
      select(productArrivalUnloadPackages)
        ..where((t) => t.productArrivalId.isInQuery(productArrivalsIdQuery))
        ..orderBy([(u) => OrderingTerm(expression: u.typeName)])
    ).watch();
    final productArrivalPackageLinesStream = (
      select(productArrivalPackageLines)
        .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
        ..where(productArrivalPackageLines.productArrivalPackageId.isInQuery(productArrivalUnloadPackagesIdQuery))
        ..orderBy([OrderingTerm(expression: products.name)])
    ).watch();

    return Rx.combineLatest5(
      productArrivalsStream,
      productArrivalLinesStream,
      productArrivalPackagesStream,
      productArrivalUnloadPackagesStream,
      productArrivalPackageLinesStream,
      (
        productArrivalsRes,
        productArrivalLinesRes,
        productArrivalPackagesRes,
        productArrivalUnloadPackagesRows,
        productArrivalPackageLinesRes
      ) {
        final productArrivalLinesRows = productArrivalLinesRes.map((line) {
          return ProductArrivalLineEx(
            line.readTable(productArrivalLines),
            line.readTable(products)
          );
        }).toList();
        final productArrivalPackageLinesRows = productArrivalPackageLinesRes.map((packageLine) {
          return ProductArrivalPackageLineEx(
            packageLine.readTable(productArrivalPackageLines),
            packageLine.readTable(products)
          );
        }).toList();
        final productArrivalPackagesRows = productArrivalPackagesRes.map((e) => ProductArrivalPackageEx(
          e,
          productArrivalPackageLinesRows.where((lineEx) => lineEx.line.productArrivalPackageId == e.id).toList()
        )).toList();

        final productArrivalRow = productArrivalsRes.firstOrNull;

        if (productArrivalRow == null) return null;

        final lines = productArrivalLinesRows
          .where((lineEx) => lineEx.line.productArrivalId == productArrivalRow.readTable(productArrivals).id)
          .toList();
        final packages = productArrivalPackagesRows
          .where((packageEx) => packageEx.package.productArrivalId == productArrivalRow.readTable(productArrivals).id)
          .toList();
        final unloadPackages = productArrivalUnloadPackagesRows
          .where((unloadPackage) => unloadPackage.productArrivalId == productArrivalRow.readTable(productArrivals).id)
          .toList();

        return ProductArrivalEx(
          productArrivalRow.readTable(productArrivals),
          lines,
          productArrivalRow.readTable(storages),
          packages,
          unloadPackages
        );
      }
    );
  }
}

class ProductArrivalEx {
  final ProductArrival productArrival;
  final Storage storage;
  final List<ProductArrivalLineEx> lines;
  final List<ProductArrivalPackageEx> packages;
  final List<ProductArrivalUnloadPackage> unloadPackages;

  ProductArrivalEx(this.productArrival, this.lines, this.storage, this.packages, this.unloadPackages);
}

class ProductArrivalLineEx {
  ProductArrivalLine line;
  Product product;

  ProductArrivalLineEx(this.line, this.product);
}

class ProductArrivalPackageEx {
  final ProductArrivalPackage package;
  final List<ProductArrivalPackageLineEx> packageLines;

  ProductArrivalPackageEx(this.package, this.packageLines);
}

class ProductArrivalPackageLineEx {
  ProductArrivalPackageLine line;
  Product product;

  ProductArrivalPackageLineEx(this.line, this.product);
}

class ProductArrivalPackageNewLineEx {
  ProductArrivalPackageNewLine line;
  Product product;

  ProductArrivalPackageNewLineEx(this.line, this.product);
}

class ProductArrivalPackageNewCellEx {
  final ProductArrivalPackageNewCell newCell;
  final Product product;
  final StorageCell storageCell;

  ProductArrivalPackageNewCellEx(this.newCell, this.product, this.storageCell);
}

class ProductArrivalPackageNewCodeEx {
  final ProductArrivalPackageNewCode newCode;
  final Product product;

  ProductArrivalPackageNewCodeEx(this.newCode, this.product);
}
