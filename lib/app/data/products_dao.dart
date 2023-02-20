part of 'database.dart';

@DriftAccessor(
  tables: [
    Products,
    ProductStores
  ],
)
class ProductsDao extends DatabaseAccessor<AppDataStore> with _$ProductsDaoMixin {
  ProductsDao(AppDataStore db) : super(db);

  Future<void> loadProducts(List<Product> list) async {
    await batch((batch) {
      batch.deleteWhere(products, (row) => const Constant(true));
      batch.insertAll(products, list, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> addProduct(Product product) async {
    await into(products).insert(product, mode: InsertMode.insertOrReplace);
  }
}
