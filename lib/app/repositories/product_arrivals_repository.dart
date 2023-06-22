import '/app/app.dart';
import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/app_store.dart';
import '/app/services/api.dart';

class ProductArrivalsRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  Api get api => store.api;

  ProductArrivalsRepository(this.store);

  Future<ProductArrivalEx> getProductArrivalEx(int id) {
    return dataStore.productArrivalsDao.getProductArrivalEx(id);
  }

  Future<List<ProductArrivalNewPackage>> getProductArrivalNewPackages(int id) {
    return dataStore.productArrivalsDao.getProductArrivalNewPackages(id);
  }

  Future<List<ProductArrivalNewUnloadPackage>> getProductArrivalNewUnloadPackages(int id) {
    return dataStore.productArrivalsDao.getProductArrivalNewUnloadPackages(id);
  }

  Future<List<ProductArrivalEx>> getProductPackageExList() {
    return dataStore.productArrivalsDao.getProductPackageExList();
  }

  Future<ProductArrivalPackageEx> getProductArrivalPackageEx(int id) {
    return dataStore.productArrivalsDao.getProductArrivalPackageEx(id);
  }

  Future<List<ProductArrivalPackageNewCellEx>> getProductArrivalPackageNewCellsEx(int id) {
    return dataStore.productArrivalsDao.getProductArrivalPackageNewCellsEx(id);
  }

  Future<List<ProductArrivalPackageNewCodeEx>> getProductArrivalPackageNewCodesEx(int id) {
    return dataStore.productArrivalsDao.getProductArrivalPackageNewCodesEx(id);
  }

  Future<List<ProductArrivalPackageNewLineEx>> getProductArrivalPackageNewLinesEx(int id) {
    return dataStore.productArrivalsDao.getProductArrivalPackageNewLinesEx(id);
  }

  Future<List<ProductArrivalPackageType>> getProductArrivalPackageTypes() {
    return dataStore.productArrivalsDao.getProductArrivalPackageTypes();
  }

  Future<void> addProductArrivalNewPackage(ProductArrivalNewPackagesCompanion newPackage) {
    return dataStore.productArrivalsDao.addProductArrivalNewPackage(newPackage);
  }

  Future<void> addProductArrivalPackageNewLine(ProductArrivalPackageNewLinesCompanion newLine) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewLine(newLine);
  }

  Future<void> addProductArrivalPackageNewCell(ProductArrivalPackageNewCellsCompanion newCell) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewCell(newCell);
  }

  Future<void> addProductArrivalPackageNewCode(ProductArrivalPackageNewCodesCompanion newCode) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewCode(newCode);
  }

  Future<void> addProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackagesCompanion newUnloadPackage) {
    return dataStore.productArrivalsDao.addProductArrivalNewUnloadPackage(newUnloadPackage);
  }

  Future<void> deleteProductArrivalNewPackage(ProductArrivalNewPackage newPackage) {
    return dataStore.productArrivalsDao.deleteProductArrivalNewPackage(newPackage);
  }

  Future<void> deleteProductArrivalPackageNewLine(ProductArrivalPackageNewLine newLine) {
    return dataStore.productArrivalsDao.deleteProductArrivalPackageNewLine(newLine);
  }

  Future<void> deleteProductArrivalPackageNewCell(ProductArrivalPackageNewCell newCell) {
    return dataStore.productArrivalsDao.deleteProductArrivalPackageNewCell(newCell);
  }

  Future<void> deleteProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackage newUnloadPackage) {
    return dataStore.productArrivalsDao.deleteProductArrivalNewUnloadPackage(newUnloadPackage);
  }

  Future<void> deleteProductArrivalPackageNewCode(ProductArrivalPackageNewCode newCode) {
    return dataStore.productArrivalsDao.deleteProductArrivalPackageNewCode(newCode);
  }

  Future<void> savePackageCodes(
    ProductArrivalPackageEx packageEx,
    List<ProductArrivalPackageNewCodeEx> newCodesEx
  ) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsSavePackageCodes(
        id: packageEx.package.id,
        codes: newCodesEx.map((e) => {
          'productId': e.newCode.productId,
          'code': e.newCode.code
        }).toList()
      );

      await dataStore.productArrivalsDao.clearProductArrivalPackageNewCodes();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<ProductArrivalEx> findProductArrival(String number) async {
    try {
      ProductArrivalEx? productArrivalEx = await dataStore.productArrivalsDao.getProductArrivalExByNumber(number);
      if (productArrivalEx != null) return productArrivalEx;

      ApiProductArrival apiProductArrival = await api.findProductArrival(number: number);
      productArrivalEx = apiProductArrival.toDatabaseEnt();

      await dataStore.transaction(() async {
        await dataStore.productArrivalsDao.updateProductArrivalEx(productArrivalEx!);
        await dataStore.storagesDao.addStorage(productArrivalEx.storage);
      });

      return productArrivalEx;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> startUnload(ProductArrivalEx productArrivalEx, int storageUnloadPointId) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsBeginUnload(
        id: productArrivalEx.productArrival.id,
        storageUnloadPointId: storageUnloadPointId
      );

      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> endUnload(
    ProductArrivalEx productArrivalEx,
    List<ProductArrivalNewPackage> newPackages,
    List<ProductArrivalNewUnloadPackage> newUnloadPackages
  ) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsFinishUnload(
        id: productArrivalEx.productArrival.id,
        packages: newPackages.map((e) => { 'productArrivalPackageTypeId': e.typeId }).toList(),
        unloadPackages: newUnloadPackages.map(
          (e) => { 'productArrivalPackageTypeId': e.typeId, 'amount': e.amount }
        ).toList()
      );

      await dataStore.productArrivalsDao.clearProductArrivalNewPackages();
      await dataStore.productArrivalsDao.clearProductArrivalNewUnloadPackages();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> startAccept(ProductArrivalPackageEx productArrivalEx, int storageAcceptPointId) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsBeginPackageAccept(
        id: productArrivalEx.package.id,
        storageAcceptPointId: storageAcceptPointId
      );

      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> endAccept(ProductArrivalPackageEx packageEx, List<ProductArrivalPackageNewLineEx> newLineExList) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsFinishPackageAccept(
        id: packageEx.package.id,
        lines: newLineExList.map((e) => { 'productId': e.product.id, 'amount': e.line.amount }).toList()
      );

      await dataStore.productArrivalsDao.clearProductArrivalPackageNewLines();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> placeProducts(
    ProductArrivalPackageEx packageEx,
    List<ProductArrivalPackageNewCellEx> newCellsEx
  ) async {
    try {
      ApiProductArrival newApiProductArrival = await api.productArrivalsPlacePackageProducts(
        id: packageEx.package.id,
        cells: newCellsEx.map((e) => {
          'storageCellId': e.newCell.storageCellId,
          'productId': e.newCell.productId,
          'amount': e.newCell.amount
        }).toList()
      );

      await dataStore.productArrivalsDao.clearProductArrivalPackageNewCells();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _saveProductArrival(ApiProductArrival apiProductArrival) async {
    ProductArrivalEx productArrivalEx = apiProductArrival.toDatabaseEnt();

    await dataStore.transaction(() async {
      await dataStore.productArrivalsDao.updateProductArrivalEx(productArrivalEx);
      await dataStore.storagesDao.addStorage(productArrivalEx.storage);
    });
  }
}
