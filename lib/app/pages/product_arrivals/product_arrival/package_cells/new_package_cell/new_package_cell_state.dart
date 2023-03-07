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
    this.newCells = const [],
    this.message = '',
    this.product,
    this.amount
  });

  final NewPackageCellStateStatus status;
  final String message;
  final ProductArrivalPackageEx packageEx;
  final StorageCell storageCell;
  final List<Product> packageLineProducts;
  final Product? product;
  final int? amount;

  final List<ProductArrivalPackageNewCellEx> newCells;

  NewPackageCellState copyWith({
    NewPackageCellStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    StorageCell? storageCell,
    final List<Product>? packageLineProducts,
    final List<ProductArrivalPackageNewCellEx>? newCells,
    String? message,
    Optional<Product>? product,
    Optional<int>? amount
  }) {
    return NewPackageCellState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      storageCell: storageCell ?? this.storageCell,
      packageLineProducts: packageLineProducts ?? this.packageLineProducts,
      newCells: newCells ?? this.newCells,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
