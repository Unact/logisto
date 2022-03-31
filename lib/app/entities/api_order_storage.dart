part of 'entities.dart';

class ApiOrderStorage {
  final int id;
  final String name;
  final int sequenceNumber;

  const ApiOrderStorage({
    required this.id,
    required this.name,
    required this.sequenceNumber
  });

  factory ApiOrderStorage.fromJson(dynamic json) {
    return ApiOrderStorage(
      id: json['id'],
      name: json['name'],
      sequenceNumber: json['sequenceNumber']
    );
  }

  OrderStorage toDatabaseEnt() {
    return OrderStorage(
      id: id,
      name: name,
      sequenceNumber: sequenceNumber
    );
  }
}
