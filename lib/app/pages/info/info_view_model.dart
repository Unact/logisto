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

    await _checkNeedRefresh();
  }

  @override
  Future<void> close() async {
    await super.close();

    await productTransferExSubscription?.cancel();
    await userSubscription?.cancel();
    await appInfoSubscription?.cancel();
  }

  Future<void> getData() async {
    await usersRepository.loadUserData();
    await appRepository.loadData();
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

  Future<void> _checkNeedRefresh() async {
    final pref = await appRepository.watchAppInfo().first;

    if (pref.lastLoadTime == null) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
      return;
    }

    DateTime lastAttempt = pref.lastLoadTime!;
    DateTime time = DateTime.now();

    if (lastAttempt.year != time.year || lastAttempt.month != time.month || lastAttempt.day != time.day) {
      emit(state.copyWith(status: InfoStateStatus.startLoad));
    }
  }
}
