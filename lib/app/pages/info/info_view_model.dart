part of 'info_page.dart';

class InfoViewModel extends PageViewModel<InfoState, InfoStateStatus> {
  InfoViewModel(BuildContext context) : super(context, InfoState());

  @override
  InfoStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => const TableUpdateQuery.any();

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: InfoStateStatus.startLoad));
  }

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: InfoStateStatus.dataLoaded,
      newVersionAvailable: await app.newVersionAvailable,
      orderExList: await app.dataStore.ordersDao.getOrderExList(),
      productArrivalExList: await app.dataStore.productArrivalsDao.getProductPackageExList(),
      user: await app.dataStore.usersDao.getUser()
    ));
  }

  Future<void> getData() async {
    if (state.status == InfoStateStatus.inProgress) return;

    emit(state.copyWith(status: InfoStateStatus.inProgress, loading: true));

    try {
      await app.loadUserData();
      await _getData();

      emit(state.copyWith(status: InfoStateStatus.success, message: 'Данные успешно обновлены', loading: false));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.failure, message: e.message, loading: false));
    }
  }

  Future<void> _getData() async {
    try {
      ApiData data = await Api(dataStore: app.dataStore).loadOrders();
      AppDataStore dataStore = app.dataStore;

      await dataStore.transaction(() async {
        List<ProductArrivalEx> productArrivalExs = data.productArrivals.map((e) => e.toDatabaseEnt()).toList();
        List<OrderEx> orderEx = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<ProductArrival> productArrivals = productArrivalExs.map((e) => e.productArrival).toList();
        List<ProductArrivalPackageEx> productArrivalPackageEx = productArrivalExs
          .map((e) => e.packages).expand((e) => e).toList();
        List<ProductArrivalPackage> productArrivalPackages = productArrivalPackageEx.map((e) => e.package).toList();
        List<ProductArrivalPackageLine> productArrivalPackageLines = productArrivalPackageEx
          .map((e) => e.packageLines).expand((e) => e).toList();
        List<ProductArrivalUnloadPackage> productArrivalUnloadPackages = productArrivalExs
          .map((e) => e.unloadPackages).expand((e) => e).toList();
        List<ProductArrivalPackageType> productArrivalPackageTypes = data.productArrivalPackageTypes
          .map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = orderEx.map((e) => e.order).toList();
        List<OrderLine> orderLines = orderEx.map((e) => e.lines).expand((e) => e).toList();
        List<Storage> storages = (
          orderEx.map((e) => e.storageTo).whereType<Storage>().toList() +
          orderEx.map((e) => e.storageFrom).whereType<Storage>().toList() +
          productArrivalExs.map((e) => e.storage).whereType<Storage>().toList() +
          data.storages.map((e) => e.toDatabaseEnt()).toList()
        ).toSet().toList();

        await dataStore.ordersDao.loadOrders(orders);
        await dataStore.ordersDao.loadOrderLines(orderLines);
        await dataStore.storagesDao.loadStorages(storages);
        await dataStore.productArrivalsDao.loadProductArrivals(productArrivals);
        await dataStore.productArrivalsDao.loadProductArrivalPackages(productArrivalPackages);
        await dataStore.productArrivalsDao.loadProductArrivalUnloadPackages(productArrivalUnloadPackages);
        await dataStore.productArrivalsDao.loadProductArrivalPackageLines(productArrivalPackageLines);
        await dataStore.productArrivalsDao.loadProductArrivalPackageTypes(productArrivalPackageTypes);
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
