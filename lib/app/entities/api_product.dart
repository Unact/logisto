part of 'entities.dart';

class ApiProduct {
  final int id;
  final String name;

  const ApiProduct({
    required this.id,
    required this.name
  });

  factory ApiProduct.fromJson(dynamic json) {
    return ApiProduct(
      id: json['id'],
      name: json['name']
    );
  }
}
