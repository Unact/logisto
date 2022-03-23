part of 'entities.dart';

class ApiOrderLine {
  final int id;
  final String name;
  final int amount;
  final double price;
  final int? factAmount;

  const ApiOrderLine({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    this.factAmount
  });

  factory ApiOrderLine.fromJson(dynamic json) {
    return ApiOrderLine(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      price: Nullify.parseDouble(json['price'])!,
      factAmount: json['factAmount'],
    );
  }
}
