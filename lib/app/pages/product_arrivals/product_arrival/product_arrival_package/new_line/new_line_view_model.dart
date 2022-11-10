part of 'new_line_page.dart';

class NewLineViewModel extends PageViewModel<NewLineState, NewLineStateStatus> {
  NewLineViewModel(BuildContext context, {required ProductArrivalPackageEx packageEx}) :
    super(context, NewLineState(packageEx: packageEx));

  @override
  NewLineStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: NewLineStateStatus.dataLoaded
    ));
  }

  Future<List<ApiProduct>> findProductsByName(String name) async {
    try {
      return await _findProduct(name: name);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: e.message));

      return [];
    }
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: NewLineStateStatus.inProgress));

    try {
      List<ApiProduct> products = await _findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      setProduct(products.first);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: e.message));
    }
  }

  void setProduct(ApiProduct product) {
    emit(state.copyWith(
      status: NewLineStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewLineStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalPackageLine() async {
    if (state.product == null) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    try {
      ProductArrivalPackageNewLinesCompanion line = ProductArrivalPackageNewLinesCompanion(
        productArrivalPackageId: Value(state.packageEx.package.id),
        productName: Value(state.product!.name),
        productId: Value(state.product!.id),
        amount: Value(state.amount!)
      );

      await app.dataStore.productArrivalsDao.addProductArrivalPackageNewLine(line);

      emit(state.copyWith(status: NewLineStateStatus.lineAdded));
    } on AppError catch(e) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: e.message));
    }
  }


  Future<List<ApiProduct>> _findProduct({String? code, String? name}) async {
    try {
      return await Api(dataStore: app.dataStore).productArrivalFindProduct(code: code, name: name);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
