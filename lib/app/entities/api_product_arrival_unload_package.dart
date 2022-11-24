part of 'entities.dart';

class ApiProductArrivalUnloadPackage {
  final int id;
  final int amount;
  final String typeName;

  const ApiProductArrivalUnloadPackage({
    required this.id,
    required this.amount,
    required this.typeName,
  });

  factory ApiProductArrivalUnloadPackage.fromJson(dynamic json) {
    return ApiProductArrivalUnloadPackage(
      id: json['id'],
      amount: json['amount'],
      typeName: json['typeName']
    );
  }
}
