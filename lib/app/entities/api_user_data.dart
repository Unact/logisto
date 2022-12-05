part of 'entities.dart';

class ApiUserData extends Equatable {
  final int id;
  final String username;
  final String email;
  final String name;
  final int? pickupStorageId;
  final List<int> storageIds;
  final String version;
  final double total;

  const ApiUserData({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    this.pickupStorageId,
    required this.storageIds,
    required this.version,
    required this.total
  });

  factory ApiUserData.fromJson(dynamic json) {
    return ApiUserData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      pickupStorageId: json['pickupStorageId'],
      storageIds: (json['storageIds'] as List).cast<int>(),
      version: json['app']['version'],
      total: Parsing.parseDouble(json['total'])!
    );
  }

  User toDatabaseEnt() {
    return User(
      id: id,
      username: username,
      name: name,
      email: email,
      pickupStorageId: pickupStorageId,
      storageIds: storageIds,
      version: version,
      total: total
    );
  }

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    name,
    pickupStorageId,
    storageIds,
    version,
    total
  ];
}
