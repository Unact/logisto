part of 'entities.dart';

class ApiProductArrivalPackageLine extends Equatable {
  final int id;
  final Product product;
  final int amount;

  const ApiProductArrivalPackageLine({
    required this.id,
    required this.amount,
    required this.product
  });

  factory ApiProductArrivalPackageLine.fromJson(dynamic json) {
    return ApiProductArrivalPackageLine(
      id: json['id'],
      amount: json['amount'],
      product: Product.fromJson(json['product'])
    );
  }

  @override
  List<Object?> get props => [
    id,
    amount,
    product
  ];
}
