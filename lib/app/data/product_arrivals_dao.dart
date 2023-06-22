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

  Future<List<ProductArrivalPackageType>> getProductArrivalPackageTypes() async {
    return select(productArrivalPackageTypes).get();
  }

  Future<List<ProductArrivalNewPackage>> getProductArrivalNewPackages(int productArrivalId) async {
    return (
      select(productArrivalNewPackages)
      ..where((e)=> e.productArrivalId.equals(productArrivalId))
    ).get();
  }

  Future<List<ProductArrivalPackageNewLineEx>> getProductArrivalPackageNewLinesEx(int productArrivalPackageId) async {
    final packageNewLinesQuery = select(productArrivalPackageNewLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageNewLines.productId))])
      ..where(productArrivalPackageNewLines.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final packageNewLinesRes = await packageNewLinesQuery.get();

    return packageNewLinesRes.map((packageLine) {
      return ProductArrivalPackageNewLineEx(
        packageLine.readTable(productArrivalPackageNewLines),
        packageLine.readTable(products)
      );
    }).toList();
  }

  Future<List<ProductArrivalPackageNewCellEx>> getProductArrivalPackageNewCellsEx(int productArrivalPackageId) async {
    final packageNewCellsQuery = select(productArrivalPackageNewCells)
      .join([
        innerJoin(products, products.id.equalsExp(productArrivalPackageNewCells.productId)),
        innerJoin(storageCells, storageCells.id.equalsExp(productArrivalPackageNewCells.storageCellId))
      ])
      ..where(productArrivalPackageNewCells.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final packageNewCellsRes = await packageNewCellsQuery.get();

    return packageNewCellsRes.map((packageCell) {
      return ProductArrivalPackageNewCellEx(
        packageCell.readTable(productArrivalPackageNewCells),
        packageCell.readTable(products),
        packageCell.readTable(storageCells)
      );
    }).toList();
  }

  Future<List<ProductArrivalPackageNewCodeEx>> getProductArrivalPackageNewCodesEx(int productArrivalPackageId) async {
    final packageNewCodesQuery = select(productArrivalPackageNewCodes)
      .join([
        innerJoin(products, products.id.equalsExp(productArrivalPackageNewCodes.productId)),
      ])
      ..where(productArrivalPackageNewCodes.productArrivalPackageId.equals(productArrivalPackageId))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final packageNewCodesRes = await packageNewCodesQuery.get();

    return packageNewCodesRes.map((packageCode) {
      return ProductArrivalPackageNewCodeEx(
        packageCode.readTable(productArrivalPackageNewCodes),
        packageCode.readTable(products)
      );
    }).toList();
  }

  Future<List<ProductArrivalNewUnloadPackage>> getProductArrivalNewUnloadPackages(int productArrivalId) async {
    return (
      select(productArrivalNewUnloadPackages)
      ..where((e)=> e.productArrivalId.equals(productArrivalId))
    ).get();
  }

  Future<List<ProductArrivalEx>> getProductPackageExList() async {
    final productArrivalsRes = await (
      select(productArrivals)
      .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
      ..orderBy([
        OrderingTerm(expression: productArrivals.id),
        OrderingTerm(expression: productArrivals.arrivalDate)
      ])
    ).get();
    final productArrivalLinesRes = await (
      select(productArrivalLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalLines.productId))])
      ..orderBy([OrderingTerm(expression: products.name)])
    ).get();
    final productArrivalPackagesRes = await (
      select(productArrivalPackages)..orderBy([(u) => OrderingTerm(expression: u.id)])
    ).get();
    final productArrivalUnloadPackagesRes = await (
      select(productArrivalUnloadPackages)..orderBy([(u) => OrderingTerm(expression: u.typeName)])
    ).get();
    final productArrivalPackageLinesRes = await (
      select(productArrivalPackageLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
      ..orderBy([OrderingTerm(expression: products.name)])
    ).get();

    return productArrivalsRes.map((productArrival) {
      final lines = productArrivalLinesRes
        .where((e) => e.readTable(productArrivalLines).productArrivalId == productArrival.readTable(productArrivals).id)
        .map((e) => ProductArrivalLineEx(e.readTable(productArrivalLines), e.readTable(products)))
        .toList();
      final packages = productArrivalPackagesRes
        .where((e) => e.productArrivalId == productArrival.readTable(productArrivals).id)
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
        .where((e) => e.productArrivalId == productArrival.readTable(productArrivals).id).toList();

      return ProductArrivalEx(
        productArrival.readTable(productArrivals),
        lines,
        productArrival.readTable(storages),
        packages,
        unloadPackages
      );
    }).toList();
  }

  Future<ProductArrivalEx> getProductArrivalEx(int id) async {
    return (await _getProductArrivalEx(productArrivals.id.equals(id))).first;
  }

  Future<ProductArrivalEx?> getProductArrivalExByNumber(String number) async {
    return(await _getProductArrivalEx(productArrivals.number.equals(number))).firstOrNull;
  }

  Future<ProductArrivalPackageEx> getProductArrivalPackageEx(int id) async {
    final packageRow = await (select(productArrivalPackages)..where((t) => t.id.equals(id))).getSingle();
    final packageLinesQuery = select(productArrivalPackageLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
      ..where(productArrivalPackageLines.productArrivalPackageId.equals(packageRow.id))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final packageLinesRes = await packageLinesQuery.get();
    final packageLinesRows = packageLinesRes.map((packageLine) {
      return ProductArrivalPackageLineEx(
        packageLine.readTable(productArrivalPackageLines),
        packageLine.readTable(products)
      );
    }).toList();

    return ProductArrivalPackageEx(packageRow, packageLinesRows);
  }

  Future<List<ProductArrivalEx>> _getProductArrivalEx(Expression<bool> whereExp) async {
    final productArrivalsQuery = select(productArrivals)
      .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
      ..orderBy([
        OrderingTerm(expression: productArrivals.id),
        OrderingTerm(expression: productArrivals.arrivalDate)
      ])
      ..where(whereExp);
    final productArrivalRows = await productArrivalsQuery.get();

    final productArrivalLinesQuery = select(productArrivalLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalLines.productId))])
      ..where(productArrivalLines.productArrivalId.isIn(productArrivalRows.map((e) => e.readTable(productArrivals).id)))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final productArrivalLinesRes = await productArrivalLinesQuery.get();
    final productArrivalLinesRows = productArrivalLinesRes.map((line) {
      return ProductArrivalLineEx(
        line.readTable(productArrivalLines),
        line.readTable(products)
      );
    }).toList();
    final productArrivalPackagesQuery = select(productArrivalPackages)
      ..where((t) => t.productArrivalId.isIn(productArrivalRows.map((e) => e.readTable(productArrivals).id)))
      ..orderBy([(u) => OrderingTerm(expression: u.id)]);
    final productArrivalPackagesRes = await productArrivalPackagesQuery.get();
    final productArrivalUnloadPackagesQuery = select(productArrivalUnloadPackages)
      ..where((t) => t.productArrivalId.isIn(productArrivalRows.map((e) => e.readTable(productArrivals).id)))
      ..orderBy([(u) => OrderingTerm(expression: u.typeName)]);
    final productArrivalUnloadPackagesRows = await productArrivalUnloadPackagesQuery.get();
    final productArrivalPackageLinesQuery = select(productArrivalPackageLines)
      .join([innerJoin(products, products.id.equalsExp(productArrivalPackageLines.productId))])
      ..where(productArrivalPackageLines.productArrivalPackageId.isIn(productArrivalPackagesRes.map((e) => e.id)))
      ..orderBy([OrderingTerm(expression: products.name)]);
    final productArrivalPackageLinesRes = await productArrivalPackageLinesQuery.get();
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

    return productArrivalRows.map((productArrivalRow) {
      final productArrival = productArrivalRow.readTable(productArrivals);
      final lines = productArrivalLinesRows
        .where((lineEx) => lineEx.line.productArrivalId == productArrival.id)
        .toList();
      final packages = productArrivalPackagesRows
        .where((packageEx) => packageEx.package.productArrivalId == productArrival.id)
        .toList();
      final unloadPackages = productArrivalUnloadPackagesRows
        .where((unloadPackage) => unloadPackage.productArrivalId == productArrival.id)
        .toList();

      return ProductArrivalEx(
        productArrival,
        lines,
        productArrivalRow.readTable(storages),
        packages,
        unloadPackages
      );
    }).toList();
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
