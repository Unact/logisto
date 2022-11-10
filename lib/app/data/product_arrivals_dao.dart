part of 'database.dart';

@DriftAccessor(
  tables: [
    ProductArrivals,
    ProductArrivalPackages,
    ProductArrivalPackageLines,
    ProductArrivalPackageTypes,
    ProductArrivalPackageNewLines,
    ProductArrivalNewPackages,
  ],
)
class ProductArrivalsDao extends DatabaseAccessor<AppDataStore> with _$ProductArrivalsDaoMixin {
  ProductArrivalsDao(AppDataStore db) : super(db);

  Future<void> loadProductArrivals(List<ProductArrival> list) async {
    await batch((batch) {
      batch.deleteWhere(productArrivals, (row) => const Constant(true));
      batch.insertAll(productArrivals, list);
    });
  }

  Future<void> loadProductArrivalPackages(List<ProductArrivalPackage> packageList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackages, (row) => const Constant(true));
      batch.insertAll(productArrivalPackages, packageList);
    });
  }

  Future<void> loadProductArrivalPackageTypes(List<ProductArrivalPackageType> packageTypeList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackageTypes, (row) => const Constant(true));
      batch.insertAll(productArrivalPackageTypes, packageTypeList);
    });
  }

  Future<void> loadProductArrivalPackageLines(List<ProductArrivalPackageLine> lineList) async {
    await batch((batch) {
      batch.deleteWhere(productArrivalPackageLines, (row) => const Constant(true));
      batch.insertAll(productArrivalPackageLines, lineList);
    });
  }

  Future<void> addProductArrivalNewPackage(ProductArrivalNewPackagesCompanion newPackage) async {
    await into(productArrivalNewPackages).insert(newPackage);
  }

  Future<void> addProductArrivalPackageNewLine(ProductArrivalPackageNewLinesCompanion newLine) async {
    await into(productArrivalPackageNewLines).insert(newLine);
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

  Future<void> updateProductArrivalEx(ProductArrivalEx productArrivalEx) async {
    await (delete(productArrivals)..where((tbl) => tbl.id.equals(productArrivalEx.productArrival.id))).go();
    await upsertProductArrival(productArrivalEx.productArrival.id, productArrivalEx.productArrival.toCompanion(false));
    await Future.forEach<ProductArrivalPackageLine>(
      productArrivalEx.packages.map((e) => e.packageLines).expand((e) => e),
      (e) => upsertProductArrivalPackageLine(e.id, e.toCompanion(false))
    );
    await Future.forEach<ProductArrivalPackageEx>(
      productArrivalEx.packages,
      (e) => upsertProductArrivalPackage(e.package.id, e.package.toCompanion(false))
    );
  }

  Future<void> clearProductArrivalNewPackages() async {
    await delete(productArrivalNewPackages).go();
  }

  Future<void> clearProductArrivalPackageNewLines() async {
    await delete(productArrivalPackageNewLines).go();
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

  Future<List<ProductArrivalPackageNewLine>> getProductArrivalPackageNewLines(int productArrivalPackageId) async {
    return (
      select(productArrivalPackageNewLines)
      ..where((e)=> e.productArrivalPackageId.equals(productArrivalPackageId))
    ).get();
  }

  Future<List<ProductArrivalEx>> getProductPackageExList() async {
    final productArrivalsRes = await (
      select(productArrivals)
      .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
      ..orderBy([
        OrderingTerm(expression: productArrivals.number),
        OrderingTerm(expression: productArrivals.arrivalDate)
      ])
    ).get();
    final productArrivalPackagesRes = await (
      select(productArrivalPackages)..orderBy([(u) => OrderingTerm(expression: u.number)])
    ).get();
    final productArrivalPackageLinesRes = await (
      select(productArrivalPackageLines)..orderBy([(u) => OrderingTerm(expression: u.productName)])
    ).get();

    return productArrivalsRes.map((productArrival) {
      final productArrivalPackages = productArrivalPackagesRes
        .where((e) => e.productArrivalId == productArrival.readTable(productArrivals).id)
        .map((e) {
          return ProductArrivalPackageEx(
            e,
            productArrivalPackageLinesRes.where((line) => line.productArrivalPackageId == e.id).toList()
          );
        })
        .toList();

      return ProductArrivalEx(
        productArrival.readTable(productArrivals),
        productArrival.readTable(storages),
        productArrivalPackages
      );
    }).toList();
  }

  Future<ProductArrivalEx> getProductArrivalEx(int id) async {
    final productArrivalsQuery = select(productArrivals)
      .join([innerJoin(storages, storages.id.equalsExp(productArrivals.storageId))])
      ..orderBy([
        OrderingTerm(expression: productArrivals.number),
        OrderingTerm(expression: productArrivals.arrivalDate)
      ])
      ..where(productArrivals.id.equals(id));
    final productArrivalPackagesQuery = select(productArrivalPackages)
      ..where((t) => t.productArrivalId.equals(id))
      ..orderBy([(u) => OrderingTerm(expression: u.number)]);
    final productArrivalPackagesRows = await productArrivalPackagesQuery.get();
    final productArrivalPackageLinesQuery = select(productArrivalPackageLines)
      ..where((t) => t.productArrivalPackageId.isIn(productArrivalPackagesRows.map((e) => e.id)))
      ..orderBy([(u) => OrderingTerm(expression: u.productName)]);
    final productArrivalPackageLinesRows = await productArrivalPackageLinesQuery.get();
    final productArrivalRow = await productArrivalsQuery.getSingle();

    return ProductArrivalEx(
      productArrivalRow.readTable(productArrivals),
      productArrivalRow.readTable(storages),
      productArrivalPackagesRows.map((e) => ProductArrivalPackageEx(
        e,
        productArrivalPackageLinesRows.where((line) => line.productArrivalPackageId == e.id).toList()
      )).toList()
    );
  }

  Future<ProductArrivalPackageEx> getProductArrivalPackageEx(int id) async {
    final productArrivalPackageRow = await (select(productArrivalPackages)..where((t) => t.id.equals(id))).getSingle();
    final productArrivalPackageLinesQuery = select(productArrivalPackageLines)
      ..where((t) => t.productArrivalPackageId.equals(productArrivalPackageRow.id))
      ..orderBy([(u) => OrderingTerm(expression: u.productName)]);
    final productArrivalPackageLinesRows = await productArrivalPackageLinesQuery.get();

    return ProductArrivalPackageEx(productArrivalPackageRow, productArrivalPackageLinesRows);
  }
}

class ProductArrivalEx {
  final ProductArrival productArrival;
  final Storage storage;
  final List<ProductArrivalPackageEx> packages;

  ProductArrivalEx(this.productArrival, this.storage, this.packages);
}

class ProductArrivalPackageEx {
  final ProductArrivalPackage package;
  final List<ProductArrivalPackageLine> packageLines;

  ProductArrivalPackageEx(this.package, this.packageLines);
}
