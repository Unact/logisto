part of 'info_page.dart';

class InfoViewModel extends PageViewModel<InfoState, InfoStateStatus> {
  final AppRepository appRepository;
  final ProductTransfersRepository productTransfersRepository;
  final UsersRepository usersRepository;

  StreamSubscription<AppInfoResult>? appInfoSubscription;
  StreamSubscription<ProductTransferEx?>? productTransferExSubscription;
  StreamSubscription<User>? userSubscription;

  InfoViewModel(
    this.appRepository,
    this.productTransfersRepository,
    this.usersRepository
  ) : super(InfoState());

  @override
  InfoStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: InfoStateStatus.startLoad));

    productTransferExSubscription = productTransfersRepository.watchCurrentTransfer().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, productTransferEx: Optional.fromNullable(event)));
    });
    userSubscription = usersRepository.watchUser().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, user: event));
    });
    appInfoSubscription = appRepository.watchAppInfo().listen((event) {
      emit(state.copyWith(status: InfoStateStatus.dataLoaded, appInfo: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productTransferExSubscription?.cancel();
    await userSubscription?.cancel();
    await appInfoSubscription?.cancel();
  }

  Future<void> getData() async {
    if (state.status == InfoStateStatus.inProgress) return;

    emit(state.copyWith(status: InfoStateStatus.inProgress, loading: true));

    try {
      await usersRepository.loadUserData();
      await appRepository.loadData();

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

    final productTransferEx = await productTransfersRepository.addProductTransfer();
    emit(state.copyWith(
      status: InfoStateStatus.startTransfer,
      productTransferEx: Optional.fromNullable(productTransferEx)
    ));
  }
}
