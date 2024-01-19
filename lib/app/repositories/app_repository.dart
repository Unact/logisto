import 'package:drift/drift.dart' show Value;
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/logisto_api.dart';

class AppRepository extends BaseRepository {
  AppRepository(AppDataStore dataStore, RenewApi api) : super(dataStore, api);

  Stream<AppInfoResult> watchAppInfo() {
    return dataStore.watchAppInfo();
  }

  Future<ApiPaymentCredentials> getApiPaymentCredentials() async {
    try {
      return await api.getPaymentCredentials();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> loadData() async {
    try {
      ApiData data = await api.loadData();

      await dataStore.transaction(() async {
        List<ProductArrivalEx> productArrivalExs = data.productArrivals.map((e) => e.toDatabaseEnt()).toList();
        List<OrderEx> orderEx = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = orderEx.map((e) => e.order).toList();
        List<OrderLineEx> orderLinesEx = orderEx.map((e) => e.lines).expand((e) => e).toList();
        List<OrderLine> orderLines = orderLinesEx.map((e) => e.line).toList();
        List<ProductArrival> productArrivals = productArrivalExs.map((e) => e.productArrival).toList();
        List<ProductArrivalLineEx> productArrivalLinesEx = productArrivalExs.map((e) => e.lines)
          .expand((e) => e).toList();
        List<ProductArrivalLine> productArrivalLines = productArrivalLinesEx.map((e) => e.line).toList();
        List<ProductArrivalPackageEx> productArrivalPackagesEx = productArrivalExs
          .map((e) => e.packages).expand((e) => e).toList();
        List<ProductArrivalPackage> productArrivalPackages = productArrivalPackagesEx.map((e) => e.package).toList();
        List<ProductArrivalPackageLineEx> productArrivalPackageLinesEx = productArrivalPackagesEx
          .map((e) => e.packageLines).expand((e) => e).toList();
        List<ProductArrivalPackageLine> productArrivalPackageLines = productArrivalPackageLinesEx
          .map((e) => e.line).toList();
        List<Product> products = (
          productArrivalPackageLinesEx.map((e) => e.product).toList()
          ..addAll(productArrivalLinesEx.map((e) => e.product).toList())
          ..addAll(orderLinesEx.where((e) => e.product != null).map((e) => e.product!).toList())
        ).toSet().toList();
        List<ProductArrivalUnloadPackage> productArrivalUnloadPackages = productArrivalExs
          .map((e) => e.unloadPackages).expand((e) => e).toList();
        List<ProductArrivalPackageType> productArrivalPackageTypes = data.productArrivalPackageTypes
          .map((e) => e.toDatabaseEnt()).toList();
        List<Storage> storages = (
          orderEx.map((e) => e.storageTo).whereType<Storage>().toList() +
          orderEx.map((e) => e.storageFrom).whereType<Storage>().toList() +
          productArrivalExs.map((e) => e.storage).whereType<Storage>().toList() +
          data.storages.map((e) => e.toDatabaseEnt()).toList()
        ).toSet().toList();
        List<ProductStore> productStores = data.productStores.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.ordersDao.loadOrders(orders);
        await dataStore.ordersDao.loadOrderLines(orderLines);
        await dataStore.storagesDao.loadStorages(storages);
        await dataStore.productsDao.loadProducts(products);
        await dataStore.productArrivalsDao.loadProductArrivals(productArrivals);
        await dataStore.productArrivalsDao.loadProductArrivalLines(productArrivalLines);
        await dataStore.productArrivalsDao.loadProductArrivalPackages(productArrivalPackages);
        await dataStore.productArrivalsDao.loadProductArrivalUnloadPackages(productArrivalUnloadPackages);
        await dataStore.productArrivalsDao.loadProductArrivalPackageLines(productArrivalPackageLines);
        await dataStore.productArrivalsDao.loadProductArrivalPackageTypes(productArrivalPackageTypes);
        await dataStore.productsDao.loadProductStores(productStores);
        await dataStore.productTransfersDao.clearProductTransfers();
        await dataStore.productArrivalsDao.clearProductArrivalNewPackages();
        await dataStore.productArrivalsDao.clearProductArrivalPackageNewLines();
        await dataStore.productArrivalsDao.clearProductArrivalPackageNewCells();
        await dataStore.productArrivalsDao.clearProductArrivalPackageNewCodes();
        await dataStore.productArrivalsDao.clearProductArrivalNewUnloadPackages();
        await dataStore.updatePref(PrefsCompanion(lastLoadTime: Value(DateTime.now())));
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> clearData() async {
    await dataStore.clearData();
  }
}
