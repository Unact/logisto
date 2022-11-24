part of 'new_unload_package_page.dart';

enum NewUnloadPackageStateStatus {
  initial,
  dataLoaded,
  failure,
  setType,
  setAmount,
  unloadPackageAdded
}

class NewUnloadPackageState {
  NewUnloadPackageState({
    this.status = NewUnloadPackageStateStatus.initial,
    this.message = '',
    required this.productArrivalEx,
    this.type,
    this.types = const [],
    this.amount
  });

  final NewUnloadPackageStateStatus status;
  final String message;
  final ProductArrivalEx productArrivalEx;
  final List<ProductArrivalPackageType> types;
  final ProductArrivalPackageType? type;
  final int? amount;

  NewUnloadPackageState copyWith({
    NewUnloadPackageStateStatus? status,
    String? message,
    ProductArrivalEx? productArrivalEx,
    List<ProductArrivalPackageType>? types,
    ProductArrivalPackageType? type,
    Optional<int>? amount
  }) {
    return NewUnloadPackageState(
      status: status ?? this.status,
      message: message ?? this.message,
      productArrivalEx: productArrivalEx ?? this.productArrivalEx,
      types: types ?? this.types,
      type: type ?? this.type,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
