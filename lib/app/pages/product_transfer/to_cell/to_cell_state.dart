part of 'to_cell_page.dart';

enum ToCellStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  setProduct,
  setAmount,
  cellAdded
}

class ToCellState {
  ToCellState({
    this.status = ToCellStateStatus.initial,
    required this.productTransferEx,
    required this.storageCell,
    this.fromCellsProducts = const [],
    this.message = '',
    this.product,
    this.amount
  });

  final ToCellStateStatus status;
  final String message;
  final ProductTransferEx productTransferEx;
  final StorageCell storageCell;
  final Product? product;
  final int? amount;

  final List<Product> fromCellsProducts;

  ToCellState copyWith({
    ToCellStateStatus? status,
    ProductTransferEx? productTransferEx,
    StorageCell? storageCell,
    List<Product>? fromCellsProducts,
    String? message,
    Optional<Product>? product,
    Optional<int>? amount
  }) {
    return ToCellState(
      status: status ?? this.status,
      productTransferEx: productTransferEx ?? this.productTransferEx,
      storageCell: storageCell ?? this.storageCell,
      fromCellsProducts: fromCellsProducts ?? this.fromCellsProducts,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
