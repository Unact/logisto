part of 'entities.dart';

class ApiProductArrivalPackageLine extends Equatable {
  final int id;
  final int productId;
  final String productName;
  final int amount;

  const ApiProductArrivalPackageLine({
    required this.id,
    required this.productId,
    required this.productName,
    required this.amount
  });

  factory ApiProductArrivalPackageLine.fromJson(dynamic json) {
    return ApiProductArrivalPackageLine(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      amount: json['amount']
    );
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    productName,
    amount
  ];
}
