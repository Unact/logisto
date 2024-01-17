part of 'from_cell_page.dart';

class FromCellViewModel extends PageViewModel<FromCellState, FromCellStateStatus> {
  final ProductTransfersRepository productTransfersRepository;
  final ProductsRepository productsRepository;

  StreamSubscription<ProductTransferEx?>? productTransferExSubscription;

  FromCellViewModel(
    this.productTransfersRepository,
    this.productsRepository,
    {
      required ProductTransferEx productTransferEx,
      required StorageCell storageCell
    }
  ) : super(FromCellState(productTransferEx: productTransferEx, storageCell: storageCell));

  @override
  FromCellStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productTransferExSubscription = productTransfersRepository.watchCurrentTransfer().listen((event) {
      emit(state.copyWith(status: FromCellStateStatus.dataLoaded, productTransferEx: event));
    });
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: FromCellStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: FromCellStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductTransferFromCell() async {
    if (state.product == null) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    await productTransfersRepository.addProductTransferFromCell(
      productTransferId: state.productTransferEx.productTransfer.id,
      storageCellId: state.storageCell.id,
      productId: state.product!.id,
      amount: state.amount!
    );

    emit(state.copyWith(
      status: FromCellStateStatus.cellAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
