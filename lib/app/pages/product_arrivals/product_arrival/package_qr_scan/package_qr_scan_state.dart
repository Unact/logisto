part of 'package_qr_scan_page.dart';

enum PackageQRScanStateStatus {
  initial,
  failure,
  finished
}

class PackageQRScanState {
  PackageQRScanState({
    required this.packages,
    this.status = PackageQRScanStateStatus.initial,
    this.packageEx,
    this.message = ''
  });

  final PackageQRScanStateStatus status;
  final String message;
  final ProductArrivalPackageEx? packageEx;
  final List<ProductArrivalPackageEx> packages;

  PackageQRScanState copyWith({
    PackageQRScanStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    List<ProductArrivalPackageEx>? packages,
    String? message
  }) {
    return PackageQRScanState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      packages: packages ?? this.packages,
      message: message ?? this.message
    );
  }
}
