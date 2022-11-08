part of '../product_arrival_qr_scan/product_arrival_qr_scan_page.dart';

enum ProductArrivalQRScanStateStatus {
  initial,
  dataLoaded,
  modeChanged,
  scanReadFinished,
  failure,
  finished
}

class ProductArrivalQRScanState {
  ProductArrivalQRScanState({
    required this.packages,
    this.status = ProductArrivalQRScanStateStatus.initial,
    this.packageEx,
    this.message = ''
  });

  final ProductArrivalQRScanStateStatus status;
  final String message;
  final ProductArrivalPackageEx? packageEx;
  final List<ProductArrivalPackageEx> packages;

  ProductArrivalQRScanState copyWith({
    ProductArrivalQRScanStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    List<ProductArrivalPackageEx>? packages,
    String? message
  }) {
    return ProductArrivalQRScanState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      packages: packages ?? this.packages,
      message: message ?? this.message
    );
  }
}
