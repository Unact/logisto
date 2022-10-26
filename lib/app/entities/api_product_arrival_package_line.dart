part of 'entities.dart';

class ApiProductArrivalPackageLine {
  final int id;
  final String productName;
  final int amount;

  const ApiProductArrivalPackageLine({
    required this.id,
    required this.productName,
    required this.amount
  });

  factory ApiProductArrivalPackageLine.fromJson(dynamic json) {
    return ApiProductArrivalPackageLine(
      id: json['id'],
      productName: json['productName'],
      amount: json['amount']
    );
  }
}
