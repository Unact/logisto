part of 'entities.dart';

class ApiProductStore extends Equatable {
  final String id;
  final String name;

  const ApiProductStore({
    required this.id,
    required this.name
  });

  factory ApiProductStore.fromJson(dynamic json) {
    return ApiProductStore(
      id: json['id'],
      name: json['name']
    );
  }

  ProductStore toDatabaseEnt() {
    return ProductStore(
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
