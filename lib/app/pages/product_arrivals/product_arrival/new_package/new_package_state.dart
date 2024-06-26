part of 'new_package_page.dart';

enum NewPackageStateStatus {
  initial,
  dataLoaded,
  failure,
  setType,
  setAmount,
  packagesAdded
}

class NewPackageState {
  NewPackageState({
    this.status = NewPackageStateStatus.initial,
    this.message = '',
    required this.productArrivalEx,
    this.type,
    this.types = const [],
    this.amount
  });

  final NewPackageStateStatus status;
  final String message;
  final ProductArrivalEx productArrivalEx;
  final List<PackageType> types;
  final PackageType? type;
  final int? amount;

  NewPackageState copyWith({
    NewPackageStateStatus? status,
    String? message,
    ProductArrivalEx? productArrivalEx,
    List<PackageType>? types,
    PackageType? type,
    Optional<int>? amount
  }) {
    return NewPackageState(
      status: status ?? this.status,
      message: message ?? this.message,
      productArrivalEx: productArrivalEx ?? this.productArrivalEx,
      types: types ?? this.types,
      type: type ?? this.type,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
