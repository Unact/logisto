part of 'entities.dart';

class ApiPackageType extends Equatable {
  final int id;
  final String name;

  const ApiPackageType({
    required this.id,
    required this.name,
  });

  factory ApiPackageType.fromJson(dynamic json) {
    return ApiPackageType(
      id: json['id'],
      name: json['name']
    );
  }

  PackageType toDatabaseEnt() {
    return PackageType(
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
