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
      orderExtendedList: await app.storage.ordersDao.getOrderExtendedList()
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
      ApiData data = await Api(storage: app.storage).loadOrders();
      AppStorage storage = app.storage;

      await storage.transaction(() async {
        List<OrderExtended> orderExtended = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = orderExtended.map((e) => e.order).toList();
        List<OrderLine> orderLines = orderExtended.map((e) => e.lines).expand<OrderLine>((e) => e).toList();
        List<OrderStorage> orderStorages = (
          orderExtended.map((e) => e.storageTo).whereType<OrderStorage>().toList() +
          orderExtended.map((e) => e.storageFrom).whereType<OrderStorage>().toList() +
          data.orderStorages.map((e) => e.toDatabaseEnt()).toList()
        ).toSet().toList();

        await storage.ordersDao.loadOrders(orders);
        await storage.ordersDao.loadOrderLines(orderLines);
        await storage.orderStoragesDao.loadOrderStorages(orderStorages);
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
