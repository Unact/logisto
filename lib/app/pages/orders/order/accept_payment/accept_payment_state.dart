part of 'accept_payment_page.dart';

enum AcceptPaymentStateStatus {
  initial,
  searchingForDevice,
  gettingCredentials,
  paymentAuthorization,
  waitingForPayment,
  paymentStarted,
  paymentFinished,
  requiredSignature,
  savingSignature,
  savingPayment,
  finished,
  failure
}

class AcceptPaymentState {
  AcceptPaymentState({
    this.status = AcceptPaymentStateStatus.initial,
    required this.order,
    required this.cardPayment,
    this.canceled = false,
    this.isCancelable = true,
    this.isRequiredSignature = false,
    this.message = '',
    this.transaction
  });

  final AcceptPaymentStateStatus status;
  final Order order;
  final bool cardPayment;
  final bool canceled;
  final bool isCancelable;
  final bool isRequiredSignature;
  final String message;
  final Map<String, dynamic>? transaction;

  AcceptPaymentState copyWith({
    AcceptPaymentStateStatus? status,
    Order? order,
    bool? cardPayment,
    bool? canceled,
    bool? isCancelable,
    bool? isRequiredSignature,
    String? message,
    Map<String, dynamic>? transaction
  }) {
    return AcceptPaymentState(
      status: status ?? this.status,
      order: order ?? this.order,
      cardPayment: cardPayment ?? this.cardPayment,
      canceled: canceled ?? this.canceled,
      isCancelable: isCancelable ?? this.isCancelable,
      isRequiredSignature: isRequiredSignature ?? this.isRequiredSignature,
      message: message ?? this.message,
      transaction: transaction ?? this.transaction
    );
  }
}
