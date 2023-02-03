part of 'entities.dart';

class ApiProduct extends Equatable {
  final int id;
  final String name;
  final String? article;
  final String? barcodeCode;
  final String? barcodeType;

  const ApiProduct({
    required this.id,
    required this.name,
    this.article,
    this.barcodeCode,
    this.barcodeType
  });

  factory ApiProduct.fromJson(dynamic json) {
    return ApiProduct(
      id: json['id'],
      name: json['name'],
      article: json['article'],
      barcodeCode: json['barcodeCode'],
      barcodeType: json['barcodeType']
    );
  }

  Product toDatabaseEnt() {
    return Product(
      id: id,
      name: name,
      article: article,
      barcodeCode: barcodeCode,
      barcodeType: barcodeType
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    article,
    barcodeCode,
    barcodeType
  ];
}
