part of 'entities.dart';

class ApiOrderLine extends Equatable {
  final int id;
  final String name;
  final int amount;
  final double price;
  final int? factAmount;
  final ApiProduct? product;

  const ApiOrderLine({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    this.factAmount,
    this.product
  });

  factory ApiOrderLine.fromJson(dynamic json) {
    return ApiOrderLine(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      price: Parsing.parseDouble(json['price'])!,
      factAmount: json['factAmount'],
      product: json['product'] != null ? ApiProduct.fromJson(json['product']) : null
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    price,
    factAmount,
    product
  ];
}
