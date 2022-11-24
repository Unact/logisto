part of 'product_arrival_page.dart';

enum ProductArrivalStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  scanSuccess,
  scanFailed
}

class ProductArrivalState {
  ProductArrivalState({
    this.status = ProductArrivalStateStatus.initial,
    required this.productArrivalEx,
    this.message = '',
    this.newPackages = const [],
    this.scanned = false
  });

  final ProductArrivalStateStatus status;
  final ProductArrivalEx productArrivalEx;
  final String message;
  final List<ProductArrivalNewPackage> newPackages;

  final bool scanned;

  ProductArrival get productArrival => productArrivalEx.productArrival;
  bool get allPackagesAcceptStarted => productArrivalEx.packages.every((e) => e.package.acceptStart != null);
  bool get unloadStarted => productArrivalEx.productArrival.unloadStart != null;
  bool get unloadInProgress => unloadStarted && productArrivalEx.productArrival.unloadEnd == null;
  bool get unloadEnded => productArrivalEx.productArrival.unloadEnd != null;

  ProductArrivalState copyWith({
    ProductArrivalStateStatus? status,
    ProductArrivalEx? productArrivalEx,
    String? message,
    List<ProductArrivalNewPackage>? newPackages,
    bool? scanned
  }) {
    return ProductArrivalState(
      status: status ?? this.status,
      productArrivalEx: productArrivalEx ?? this.productArrivalEx,
      message: message ?? this.message,
      newPackages: newPackages ?? this.newPackages,
      scanned: scanned ?? this.scanned
    );
  }
}
