part of 'entities.dart';

class ApiStorage extends Equatable {
  final int id;
  final String name;
  final int sequenceNumber;

  const ApiStorage({
    required this.id,
    required this.name,
    required this.sequenceNumber
  });

  factory ApiStorage.fromJson(dynamic json) {
    return ApiStorage(
      id: json['id'],
      name: json['name'],
      sequenceNumber: json['sequenceNumber']
    );
  }

  Storage toDatabaseEnt() {
    return Storage(
      id: id,
      name: name,
      sequenceNumber: sequenceNumber
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    sequenceNumber
  ];
}
