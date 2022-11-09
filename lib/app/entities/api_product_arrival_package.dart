part of 'entities.dart';

class ApiProductArrivalPackage {
  final int id;
  final String number;
  final String typeName;
  final DateTime? acceptStart;
  final DateTime? acceptEnd;
  final List<ApiProductArrivalPackageLine> lines;

  const ApiProductArrivalPackage({
    required this.id,
    required this.number,
    required this.typeName,
    this.acceptStart,
    this.acceptEnd,
    required this.lines,
  });

  factory ApiProductArrivalPackage.fromJson(dynamic json) {
    return ApiProductArrivalPackage(
      id: json['id'],
      number: json['number'],
      typeName: json['typeName'],
      acceptStart: Parsing.parseDate(json['acceptStart']),
      acceptEnd: Parsing.parseDate(json['acceptEnd']),
      lines: json['lines'].map<ApiProductArrivalPackageLine>((e) => ApiProductArrivalPackageLine.fromJson(e)).toList(),
    );
  }
}
