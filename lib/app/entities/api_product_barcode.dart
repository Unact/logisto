part of 'entities.dart';

class ApiProductBarcode extends Equatable {
  final int id;
  final String type;
  final String code;

  const ApiProductBarcode({
    required this.id,
    required this.type,
    required this.code
  });

  factory ApiProductBarcode.fromJson(dynamic json) {
    return ApiProductBarcode(
      id: json['id'],
      type: json['type'],
      code: json['code']
    );
  }

  @override
  List<Object?> get props => [
    id,
    code,
    type
  ];
}
