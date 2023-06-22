part of 'package_codes_page.dart';

enum PackageCodesStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  addCode,
  needUserConfirmation
}

class PackageCodesState {
  PackageCodesState({
    this.status = PackageCodesStateStatus.initial,
    required this.packageEx,
    this.message = '',
    this.newCodes = const [],
    required this.confirmationCallback,
  });

  final PackageCodesStateStatus status;
  final ProductArrivalPackageEx packageEx;
  final String message;
  final List<ProductArrivalPackageNewCodeEx> newCodes;
  final Function confirmationCallback;

  List<Product> get products => packageEx.packageLines
    .where((e) => e.product.needMarking)
    .map((e) => e.product)
    .toSet().toList();

  PackageCodesState copyWith({
    PackageCodesStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    List<ProductArrivalPackageNewCodeEx>? newCodes,
    Function? confirmationCallback,
  }) {
    return PackageCodesState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      newCodes: newCodes ?? this.newCodes,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
    );
  }
}
