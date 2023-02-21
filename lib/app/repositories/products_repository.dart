import '/app/app.dart';
import '/app/constants/strings.dart';

import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/app_store.dart';
import '/app/services/api.dart';

class ProductsRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  Api get api => store.api;

  ProductsRepository(this.store);

  Future<List<ProductStore>> getProductStores() {
    return dataStore.productsDao.getProductStores();
  }

  Future<List<Product>> findProduct({String? code, String? name}) async {
    try {
      List<ApiProduct> apiProducts =  await api.productsFindProduct(code: code, name: name);
      List<Product> products = apiProducts.map((e) => e.toDatabaseEnt()).toList();

      await dataStore.transaction(() async {
        await Future.wait(products.map((e) => dataStore.productsDao.addProduct(e)));
      });

      return products;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
