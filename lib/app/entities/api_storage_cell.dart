part of 'entities.dart';

class ApiStorageCell extends Equatable {
  final int id;
  final String name;

  const ApiStorageCell({
    required this.id,
    required this.name
  });

  factory ApiStorageCell.fromJson(dynamic json) {
    return ApiStorageCell(
      id: json['id'],
      name: json['name']
    );
  }

  @override
  List<Object?> get props => [
    id,
    name
  ];
}
