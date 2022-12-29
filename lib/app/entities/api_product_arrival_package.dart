part of 'entities.dart';

class ApiProductArrivalPackage extends Equatable {
  final int id;
  final String number;
  final String typeName;
  final String qr;
  final DateTime? acceptStart;
  final DateTime? acceptEnd;
  final DateTime? placed;
  final List<ApiProductArrivalPackageLine> lines;

  const ApiProductArrivalPackage({
    required this.id,
    required this.number,
    required this.typeName,
    required this.qr,
    this.acceptStart,
    this.acceptEnd,
    this.placed,
    required this.lines,
  });

  factory ApiProductArrivalPackage.fromJson(dynamic json) {
    return ApiProductArrivalPackage(
      id: json['id'],
      number: json['number'],
      typeName: json['typeName'],
      qr: json['qr'],
      acceptStart: Parsing.parseDate(json['acceptStart']),
      acceptEnd: Parsing.parseDate(json['acceptEnd']),
      placed: Parsing.parseDate(json['placed']),
      lines: json['lines'].map<ApiProductArrivalPackageLine>((e) => ApiProductArrivalPackageLine.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    number,
    typeName,
    qr,
    acceptStart,
    acceptEnd,
    placed,
    lines
  ];
}
