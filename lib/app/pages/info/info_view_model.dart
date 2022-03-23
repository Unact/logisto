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
      ordersWithLines: await app.storage.ordersDao.getOrdersWithLines(),
    ));
  }

  Future<void> getData() async {
    if (state.status == InfoStateStatus.inProgress) return;

    emit(state.copyWith(status: InfoStateStatus.inProgress));

    try {
      await app.loadUserData();
      await _getData();

      emit(state.copyWith(status: InfoStateStatus.success, message: 'Данные успешно обновлены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.failure, message: e.message));
    }
  }

  Future<void> _getData() async {
    try {
      ApiData data = await Api(storage: app.storage).loadOrders();
      AppStorage storage = app.storage;

      await storage.transaction(() async {
        List<OrderWithLines> orderWithLines = data.orders.map((e) => e.toDatabaseEnt()).toList();
        List<Order> orders = orderWithLines.map((e) => e.order).toList();
        List<OrderLine> orderLines = orderWithLines.map((e) => e.lines).expand<OrderLine>((e) => e).toList();
        List<OrderStorage> orderStorages = data.orderStorages.map((e) => e.toDatabaseEnt()).toList();

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
