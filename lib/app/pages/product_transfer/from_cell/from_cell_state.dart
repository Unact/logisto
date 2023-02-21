part of 'from_cell_page.dart';

enum FromCellStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  setProduct,
  setAmount,
  cellAdded
}

class FromCellState {
  FromCellState({
    this.status = FromCellStateStatus.initial,
    required this.productTransferEx,
    required this.storageCell,
    this.message = '',
    this.product,
    this.amount
  });

  final FromCellStateStatus status;
  final String message;
  final ProductTransferEx productTransferEx;
  final StorageCell storageCell;
  final Product? product;
  final int? amount;

  FromCellState copyWith({
    FromCellStateStatus? status,
    ProductTransferEx? productTransferEx,
    StorageCell? storageCell,
    String? message,
    Optional<Product>? product,
    Optional<int>? amount
  }) {
    return FromCellState(
      status: status ?? this.status,
      productTransferEx: productTransferEx ?? this.productTransferEx,
      storageCell: storageCell ?? this.storageCell,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
