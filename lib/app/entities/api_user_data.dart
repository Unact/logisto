part of 'entities.dart';

class ApiUserData {
  final int id;
  final String username;
  final String email;
  final String name;
  final String storageName;
  final List<String> roles;
  final String version;

  const ApiUserData({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.storageName,
    required this.roles,
    required this.version
  });

  factory ApiUserData.fromJson(dynamic json) {
    return ApiUserData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      storageName: json['storageName'],
      roles: (json['roles'] as List).cast<String>(),
      version: json['app']['version']
    );
  }

  User toDatabaseEnt() {
    return User(
      id: id,
      username: username,
      name: name,
      email: email,
      storageName: storageName,
      roles: roles,
      version: version
    );
  }
}
