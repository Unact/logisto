import 'package:cross_file/cross_file.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';

import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/logisto_api.dart';

class ProductsRepository extends BaseRepository {
  ProductsRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<List<ProductStore>> watchProductStores() {
    return dataStore.productsDao.watchProductStores();
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
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<List<ApiProductBarcode>> getProductBarcodes(Product product) async {
    try {
      List<ApiProductBarcode> productBarcodes = await api.productBarcodes(productId: product.id);

      return productBarcodes;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<ApiProductBarcode> createProductBarcode(Product product, {
    required String code,
    required String type
  }) async {
    try {
      ApiProductBarcode productBarcode = await api.productBarcodesCreate(
        productId: product.id,
        code: code,
        type: type
      );

      return productBarcode;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<List<ApiProductImage>> getProductImages(Product product) async {
    try {
      List<ApiProductImage> productImages = await api.productImages(productId: product.id);

      return productImages;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<ApiProductImage> createProductImage(Product product, {
    required XFile file
  }) async {
    try {
      ApiProductImage productImage = await api.productImagesCreate(productId: product.id, file: file);

      return productImage;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
