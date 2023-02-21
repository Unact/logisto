part of 'entities.dart';

class ApiProductArrivalLine extends Equatable {
  final int id;
  final Product product;
  final int amount;
  final bool enumeratePiece;

  const ApiProductArrivalLine({
    required this.id,
    required this.amount,
    required this.product,
    required this.enumeratePiece
  });

  factory ApiProductArrivalLine.fromJson(dynamic json) {
    return ApiProductArrivalLine(
      id: json['id'],
      amount: json['amount'],
      product: Product.fromJson(json['product']),
      enumeratePiece: json['enumeratePiece']
    );
  }

  @override
  List<Object?> get props => [
    id,
    amount,
    product,
    enumeratePiece
  ];
}
