part of 'product_arrival_page.dart';

enum ProductArrivalStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  productArrivalScanSuccess,
  productArrivalScanFailed
}

class ProductArrivalState {
  ProductArrivalState({
    this.status = ProductArrivalStateStatus.initial,
    required this.productArrivalEx,
    this.message = '',
    this.newPackages = const [],
    this.newUnloadPackages = const [],
    this.scanned = false
  });

  final ProductArrivalStateStatus status;
  final ProductArrivalEx productArrivalEx;
  final String message;
  final List<ProductArrivalNewPackage> newPackages;
  final List<ProductArrivalNewUnloadPackage> newUnloadPackages;

  final bool scanned;

  ProductArrival get productArrival => productArrivalEx.productArrival;
  bool get anyPackageAcceptStarted => productArrivalEx.packages.any((e) => e.package.acceptStart != null);
  bool get allPackagesAcceptStarted => productArrivalEx.packages.every((e) => e.package.acceptStart != null);
  bool get unloadStarted => productArrivalEx.productArrival.unloadStart != null;
  bool get unloadInProgress => unloadStarted && productArrivalEx.productArrival.unloadEnd == null;
  bool get unloadEnded => productArrivalEx.productArrival.unloadEnd != null;

  ProductArrivalState copyWith({
    ProductArrivalStateStatus? status,
    ProductArrivalEx? productArrivalEx,
    String? message,
    List<ProductArrivalNewPackage>? newPackages,
    List<ProductArrivalNewUnloadPackage>? newUnloadPackages,
    bool? scanned
  }) {
    return ProductArrivalState(
      status: status ?? this.status,
      productArrivalEx: productArrivalEx ?? this.productArrivalEx,
      message: message ?? this.message,
      newPackages: newPackages ?? this.newPackages,
      newUnloadPackages: newUnloadPackages ?? this.newUnloadPackages,
      scanned: scanned ?? this.scanned
    );
  }
}
