part of 'product_arrival_package_page.dart';

enum ProductArrivalStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure
}

class ProductArrivalPackageState {
  ProductArrivalPackageState({
    this.status = ProductArrivalStateStatus.initial,
    required this.packageEx,
    this.message = '',
    this.newLines = const []
  });

  final ProductArrivalStateStatus status;
  final ProductArrivalPackageEx packageEx;
  final String message;
  final List<ProductArrivalPackageNewLine> newLines;

  bool get inProgress => packageEx.package.acceptStart != null && packageEx.package.acceptEnd == null;

  ProductArrivalPackageState copyWith({
    ProductArrivalStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    List<ProductArrivalPackageNewLine>? newLines,
    List<ProductArrivalNewPackage>? newPackages
  }) {
    return ProductArrivalPackageState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      newLines: newLines ?? this.newLines
    );
  }
}
