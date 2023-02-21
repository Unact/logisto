part of 'product_transfer_page.dart';

enum ProductTransferStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  addFromCell,
  addToCell,
  gatherFinished,
  gatherFinishCanceled
}

class ProductTransferState {
  ProductTransferState({
    this.status = ProductTransferStateStatus.initial,
    required this.productTransferEx,
    this.message = '',
    this.productStores = const [],
    this.user,
    this.scannedStorageCell
  });

  final ProductTransferStateStatus status;
  final ProductTransferEx productTransferEx;
  final String message;
  final User? user;
  final StorageCell? scannedStorageCell;

  bool get gatherFinished => productTransferEx.productTransfer.gatherFinished;

  List<String> get fromCellStorageCellNames => productTransferEx.fromCells
    .map((e) => e.storageCell.name).toSet().toList()..sort((a, b) => a.compareTo(b));

  List<String> get toCellStorageCellNames => productTransferEx.toCells
    .map((e) => e.storageCell.name).toSet().toList()..sort((a, b) => a.compareTo(b));

  final List<ProductStore> productStores;

  ProductTransferState copyWith({
    ProductTransferStateStatus? status,
    ProductTransferEx? productTransferEx,
    String? message,
    List<ProductStore>? productStores,
    User? user,
    Optional<StorageCell>? scannedStorageCell
  }) {
    return ProductTransferState(
      status: status ?? this.status,
      productTransferEx: productTransferEx ?? this.productTransferEx,
      message: message ?? this.message,
      productStores: productStores ?? this.productStores,
      user: user ?? this.user,
      scannedStorageCell: scannedStorageCell != null ? scannedStorageCell.orNull : this.scannedStorageCell
    );
  }
}
