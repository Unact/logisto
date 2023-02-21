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
      orderExList: await store.ordersRepo.getOrderExList(),
      productArrivalExList: await store.productArrivalsRepo.getProductPackageExList(),
      user: await store.usersRepo.getUser(),
      productTransferEx: Optional.fromNullable(await store.productTransfersRepo.getCurrentTransfer())
    ));
  }

  Future<void> getData() async {
    if (state.status == InfoStateStatus.inProgress) return;

    emit(state.copyWith(status: InfoStateStatus.inProgress, loading: true));

    try {
      await store.usersRepo.loadUserData();
      await store.loadData();

      emit(state.copyWith(status: InfoStateStatus.success, message: 'Данные успешно обновлены', loading: false));
    } on AppError catch(e) {
      emit(state.copyWith(status: InfoStateStatus.failure, message: e.message, loading: false));
    }
  }

  Future<void> startTransfer() async {
    if (state.productTransferEx != null) {
      emit(state.copyWith(status: InfoStateStatus.startTransfer));
      return;
    }

    await store.productTransfersRepo.addProductTransfer(const ProductTransfersCompanion(gatherFinished: Value(false)));
    emit(state.copyWith(
      status: InfoStateStatus.startTransfer,
      productTransferEx: Optional.fromNullable(await store.productTransfersRepo.getCurrentTransfer())
    ));
  }
}
