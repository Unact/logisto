part of 'new_package_cell_page.dart';

class NewPackageCellViewModel extends PageViewModel<NewPackageCellState, NewPackageCellStateStatus> {
  final ProductsRepository productsRepository;
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<List<ProductArrivalPackageNewCellEx>>? productArrivalPackageNewCellExListSubscription;

  NewPackageCellViewModel(
    this.productsRepository,
    this.productArrivalsRepository,
    {
      required ProductArrivalPackageEx packageEx,
      required StorageCell storageCell
    }
  ) : super(NewPackageCellState(packageEx: packageEx, storageCell: storageCell));

  @override
  NewPackageCellStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productArrivalPackageNewCellExListSubscription = productArrivalsRepository
      .watchProductArrivalPackageNewCellsEx(state.packageEx.package.id).listen((event) {
        emit(state.copyWith(
          status: NewPackageCellStateStatus.dataLoaded,
          packageLineProducts: _calcNewCellsProducts(state.packageEx.packageLines, event),
          newCells: event
        ));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageNewCellExListSubscription?.cancel();
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: NewPackageCellStateStatus.inProgress));

    try {
      List<Product> products = await productsRepository.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      Product product = products.first;

      if (!state.packageLineProducts.contains(product)) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Товар не принимался'));
        return;
      }

      setProduct(product);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: NewPackageCellStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewPackageCellStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalPackageNewPackageCell() async {
    int productAmount = state.packageEx.packageLines.fold(
      0,
      (prev, e) => prev + (e.product == state.product ? e.line.amount : 0)
    );
    int productNewCellsAmount = state.newCells.fold(
      0,
      (prev, e) => prev + (e.product == state.product ? e.newCell.amount : 0)
    );

    if (state.product == null) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    if (productAmount < productNewCellsAmount + state.amount!) {
      emit(state.copyWith(
        status: NewPackageCellStateStatus.failure,
        message: 'Нельзя разместить товара больше чем принято'
      ));
      return;
    }

    await productArrivalsRepository.addProductArrivalPackageNewCell(
      productArrivalPackageId: state.packageEx.package.id,
      productId: state.product!.id,
      storageCellId: state.storageCell.id,
      amount: state.amount!
    );

    emit(state.copyWith(
      status: NewPackageCellStateStatus.lineAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }

  List<Product> _calcNewCellsProducts(
    List<ProductArrivalPackageLineEx> packageLines,
    List<ProductArrivalPackageNewCellEx> newCells
  ) {
    final productsMap = packageLines.map((e) => e.product).toSet().toList()
      .fold<Map<Product, int>>(
        {},
        (prevProductMap, product) => prevProductMap..addAll({
          product: packageLines.where((e) => e.product == product)
            .fold<int>(0, (prev, e) => e.line.amount + prev)
        })
      );

    for (var e in newCells) {
      if (productsMap[e.product] == null) continue;
      productsMap[e.product] = productsMap[e.product]! - e.newCell.amount;
    }
    productsMap.removeWhere((key, value) => value == 0);

    return productsMap.keys.toList();
  }
}
