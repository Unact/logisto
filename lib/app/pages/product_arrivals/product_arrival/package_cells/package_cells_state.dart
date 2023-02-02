part of 'package_cells_page.dart';

enum PackageCellsStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  setCell
}

class PackageCellsState {
  PackageCellsState({
    this.status = PackageCellsStateStatus.initial,
    required this.packageEx,
    this.message = '',
    this.storageCell,
    this.newCells = const [],
  });

  final PackageCellsStateStatus status;
  final ProductArrivalPackageEx packageEx;
  final String message;
  final ApiStorageCell? storageCell;
  final List<ProductArrivalPackageNewCellEx> newCells;

  List<String> get storageCellNames => newCells.map((e) => e.newCell.storageCellName).toSet().toList()
    ..sort((a, b) => a.compareTo(b));

  PackageCellsState copyWith({
    PackageCellsStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    Optional<ApiStorageCell>? storageCell,
    List<ProductArrivalPackageNewCellEx>? newCells
  }) {
    return PackageCellsState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      storageCell: storageCell != null ? storageCell.orNull : this.storageCell,
      newCells: newCells ?? this.newCells
    );
  }
}
