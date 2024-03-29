part of 'entities.dart';

class ApiProduct extends Equatable {
  final int id;
  final String name;
  final String groupName;
  final String? article;
  final int? length;
  final int? width;
  final int? height;
  final int? weight;
  final bool archived;
  final bool needMarking;
  final bool inPackage;

  const ApiProduct({
    required this.id,
    required this.name,
    required this.groupName,
    required this.archived,
    this.article,
    this.length,
    this.width,
    this.height,
    this.weight,
    required this.needMarking,
    required this.inPackage
  });

  factory ApiProduct.fromJson(dynamic json) {
    return ApiProduct(
      id: json['id'],
      name: json['name'],
      groupName: json['groupName'],
      archived: json['archived'],
      article: json['article'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
      needMarking: json['needMarking'],
      inPackage: json['inPackage']
    );
  }

  Product toDatabaseEnt() {
    return Product(
      id: id,
      name: name,
      groupName: groupName,
      archived: archived,
      article: article,
      length: length,
      width: width,
      height: height,
      weight: weight,
      needMarking: needMarking,
      inPackage: inPackage
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    groupName,
    article,
    length,
    width,
    height,
    weight,
    archived,
    needMarking,
    inPackage
  ];
}
