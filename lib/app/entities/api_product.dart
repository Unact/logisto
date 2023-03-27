part of 'entities.dart';

class ApiProduct extends Equatable {
  final int id;
  final String name;
  final String groupName;
  final String? article;
  final String? barcodeCode;
  final String? barcodeType;
  final int? length;
  final int? width;
  final int? height;
  final int? weight;
  final bool archived;

  const ApiProduct({
    required this.id,
    required this.name,
    required this.groupName,
    required this.archived,
    this.article,
    this.barcodeCode,
    this.barcodeType,
    this.length,
    this.width,
    this.height,
    this.weight,
  });

  factory ApiProduct.fromJson(dynamic json) {
    return ApiProduct(
      id: json['id'],
      name: json['name'],
      groupName: json['groupName'],
      archived: json['archived'],
      article: json['article'],
      barcodeCode: json['barcodeCode'],
      barcodeType: json['barcodeType'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Product toDatabaseEnt() {
    return Product(
      id: id,
      name: name,
      groupName: groupName,
      archived: archived,
      article: article,
      barcodeCode: barcodeCode,
      barcodeType: barcodeType,
      length: length,
      width: width,
      height: height,
      weight: weight,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    groupName,
    article,
    barcodeCode,
    barcodeType,
    length,
    width,
    height,
    weight,
    archived
  ];
}
