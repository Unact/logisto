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
    this.newLineExList = const [],
    this.user
  });

  final PackageStateStatus status;
  final ProductArrivalPackageEx packageEx;
  final String message;
  final List<ProductArrivalPackageNewLineEx> newLineExList;
  final User? user;

  bool get inProgress => packageEx.package.acceptStart != null && packageEx.package.acceptEnd == null;

  PackageState copyWith({
    PackageStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    List<ProductArrivalPackageNewLineEx>? newLineExList,
    User? user
  }) {
    return PackageState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      newLineExList: newLineExList ?? this.newLineExList,
      user: user ?? this.user
    );
  }
}
