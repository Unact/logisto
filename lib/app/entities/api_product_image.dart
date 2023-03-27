part of 'entities.dart';

class ApiProductImage extends Equatable {
  final int id;
  final String url;

  const ApiProductImage({
    required this.id,
    required this.url
  });

  factory ApiProductImage.fromJson(dynamic json) {
    return ApiProductImage(
      id: json['id'],
      url: json['url']
    );
  }

  @override
  List<Object?> get props => [
    id,
    url
  ];
}
