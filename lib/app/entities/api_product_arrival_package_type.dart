part of 'entities.dart';

class ApiProductArrivalPackageType extends Equatable {
  final int id;
  final String name;

  const ApiProductArrivalPackageType({
    required this.id,
    required this.name,
  });

  factory ApiProductArrivalPackageType.fromJson(dynamic json) {
    return ApiProductArrivalPackageType(
      id: json['id'],
      name: json['name']
    );
  }

  ProductArrivalPackageType toDatabaseEnt() {
    return ProductArrivalPackageType(
      id: id,
      name: name
    );
  }

  @override
  List<Object?> get props => [
    id,
    name
  ];
}
