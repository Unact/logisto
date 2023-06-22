part of 'code_scan_page.dart';

enum CodeScanStateStatus {
  initial,
  dataLoaded,
  scanReadFinished,
  failure,
  success
}

class CodeScanState {
  CodeScanState({
    this.status = CodeScanStateStatus.initial,
    this.message = '',
    required this.packageEx,
    required this.product,
    this.newCodes = const []
  });

  final CodeScanStateStatus status;
  final String message;
  final Product product;
  final ProductArrivalPackageEx packageEx;
  final List<ProductArrivalPackageNewCodeEx> newCodes;

  int get total => packageEx.packageLines.where((e) => e.product == product).fold(0, (acc, el) => acc + el.line.amount);

  CodeScanState copyWith({
    CodeScanStateStatus? status,
    String? message,
    Product? product,
    ProductArrivalPackageEx? packageEx,
    List<ProductArrivalPackageNewCodeEx>? newCodes
  }) {
    return CodeScanState(
      status: status ?? this.status,
      message: message ?? this.message,
      product: product ?? this.product,
      packageEx: packageEx ?? this.packageEx,
      newCodes: newCodes ?? this.newCodes
    );
  }
}
