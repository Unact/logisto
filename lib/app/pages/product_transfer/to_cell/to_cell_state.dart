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

  List<Product> get fromCellsProducts => productTransferEx.fromCells.map((e) => e.product).toSet().toList();

  ToCellState copyWith({
    ToCellStateStatus? status,
    ProductTransferEx? productTransferEx,
    StorageCell? storageCell,
    String? message,
    Optional<Product>? product,
    Optional<int>? amount
  }) {
    return ToCellState(
      status: status ?? this.status,
      productTransferEx: productTransferEx ?? this.productTransferEx,
      storageCell: storageCell ?? this.storageCell,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
