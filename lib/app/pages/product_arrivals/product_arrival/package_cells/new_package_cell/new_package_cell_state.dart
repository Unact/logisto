part of 'new_package_cell_page.dart';

enum NewPackageCellStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  setProduct,
  setAmount,
  lineAdded
}

class NewPackageCellState {
  NewPackageCellState({
    this.status = NewPackageCellStateStatus.initial,
    required this.packageEx,
    required this.storageCell,
    this.packageLineProducts = const [],
    this.message = '',
    this.product,
    this.amount
  });

  final NewPackageCellStateStatus status;
  final String message;
  final ProductArrivalPackageEx packageEx;
  final ApiStorageCell storageCell;
  final List<Product> packageLineProducts;
  final Product? product;
  final int? amount;

  NewPackageCellState copyWith({
    NewPackageCellStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    ApiStorageCell? storageCell,
    final List<Product>? packageLineProducts,
    String? message,
    Optional<Product>? product,
    Optional<int>? amount
  }) {
    return NewPackageCellState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      storageCell: storageCell ?? this.storageCell,
      packageLineProducts: packageLineProducts ?? this.packageLineProducts,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
