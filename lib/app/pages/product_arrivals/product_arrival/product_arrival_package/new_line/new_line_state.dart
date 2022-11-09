part of 'new_line_page.dart';

enum NewLineStateStatus {
  initial,
  dataLoaded,
  startLoad,
  inProgress,
  success,
  failure,
  setProduct,
  setAmount,
  lineAdded
}

class NewLineState {
  NewLineState({
    this.status = NewLineStateStatus.initial,
    required this.packageEx,
    this.message = '',
    this.product,
    this.amount
  });

  final NewLineStateStatus status;
  final String message;
  final ProductArrivalPackageEx packageEx;
  final ApiProduct? product;
  final int? amount;

  NewLineState copyWith({
    NewLineStateStatus? status,
    ProductArrivalPackageEx? packageEx,
    String? message,
    Optional<ApiProduct>? product,
    Optional<int>? amount
  }) {
    return NewLineState(
      status: status ?? this.status,
      packageEx: packageEx ?? this.packageEx,
      message: message ?? this.message,
      product: product != null ? product.orNull : this.product,
      amount: amount != null ? amount.orNull : this.amount,
    );
  }
}
