import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/logisto_api.dart';

class ProductArrivalsRepository extends BaseRepository {
  ProductArrivalsRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<ProductArrivalEx?> watchProductArrivalEx(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalEx(id);
  }

  Stream<List<ProductArrivalNewPackage>> watchProductArrivalNewPackages(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalNewPackages(id);
  }

  Stream<List<ProductArrivalNewUnloadPackage>> watchProductArrivalNewUnloadPackages(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalNewUnloadPackages(id);
  }

  Stream<List<ProductArrivalEx>> watchProductPackageExList() {
    return dataStore.productArrivalsDao.watchProductPackageExList();
  }

  Stream<ProductArrivalPackageEx> watchProductArrivalPackageEx(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalPackageEx(id);
  }

  Stream<List<ProductArrivalPackageNewCellEx>> watchProductArrivalPackageNewCellsEx(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalPackageNewCellsEx(id);
  }

  Stream<List<ProductArrivalPackageNewCodeEx>> watchProductArrivalPackageNewCodesEx(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalPackageNewCodesEx(id);
  }

  Stream<List<ProductArrivalPackageNewLineEx>> watchProductArrivalPackageNewLinesEx(int id) {
    return dataStore.productArrivalsDao.watchProductArrivalPackageNewLinesEx(id);
  }

  Stream<List<ProductArrivalPackageType>> watchProductArrivalPackageTypes() {
    return dataStore.productArrivalsDao.watchProductArrivalPackageTypes();
  }

  Future<void> addProductArrivalNewPackage({
    required int productArrivalId,
    required int typeId,
    required String typeName,
    required String number,
  }) {
    return dataStore.productArrivalsDao.addProductArrivalNewPackage(
      ProductArrivalNewPackagesCompanion.insert(
        productArrivalId: productArrivalId,
        typeId: typeId,
        typeName: typeName,
        number: number
      )
    );
  }

  Future<void> addProductArrivalPackageNewLine({
    required int productArrivalPackageId,
    required int productId,
    required int amount
  }) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewLine(
      ProductArrivalPackageNewLinesCompanion.insert(
        productArrivalPackageId: productArrivalPackageId,
        productId: productId,
        amount: amount
      )
    );
  }

  Future<void> addProductArrivalPackageNewCell({
    required int productArrivalPackageId,
    required int productId,
    required int storageCellId,
    required int amount
  }) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewCell(
      ProductArrivalPackageNewCellsCompanion.insert(
        productArrivalPackageId: productArrivalPackageId,
        productId: productId,
        storageCellId: storageCellId,
        amount: amount
      )
    );
  }

  Future<void> addProductArrivalPackageNewCode({
    required int productArrivalPackageId,
    required int productId,
    required String code
  }) {
    return dataStore.productArrivalsDao.addProductArrivalPackageNewCode(
      ProductArrivalPackageNewCodesCompanion.insert(
        productArrivalPackageId: productArrivalPackageId,
        productId: productId,
        code: code
      )
    );
  }

  Future<void> addProductArrivalNewUnloadPackage({
    required int productArrivalId,
    required String typeName,
    required int typeId,
    required int amount
  }) {
    return dataStore.productArrivalsDao.addProductArrivalNewUnloadPackage(
      ProductArrivalNewUnloadPackagesCompanion.insert(
        productArrivalId: productArrivalId,
        amount: amount,
        typeId: typeId,
        typeName: typeName
      )
    );
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
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<ProductArrivalEx> findProductArrival(String number) async {
    try {
      ProductArrivalEx? productArrivalEx =
        await dataStore.productArrivalsDao.watchProductArrivalExByNumber(number).first;
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
      await Misc.reportError(e, trace);
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
      await Misc.reportError(e, trace);
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
      await Misc.reportError(e, trace);
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
      await Misc.reportError(e, trace);
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
      await Misc.reportError(e, trace);
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
      await Misc.reportError(e, trace);
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
