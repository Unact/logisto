part of 'package_page.dart';

enum PackageStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure
}

class PackageState {
  PackageState({
    this.status = PackageStateStatus.initial,
    required this.packageEx,
    this.message = '',
    this.newLines = const []
  });

  final PackageStateStatus status;
  final ProductArrivalPackageEx packageEx;
  final String message;
  final List<ProductArrivalPackageNewLine> newLines;

  bool get inProgress => packageEx.package.acceptStart != null && packageEx.package.acceptEnd == null;

  PackageState copyWith({
    PackageStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    List<ProductArrivalPackageNewLine>? newLines
  }) {
    return PackageState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      newLines: newLines ?? this.newLines
    );
  }
}
