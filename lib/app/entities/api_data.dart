part of 'entities.dart';

class ApiData extends Equatable {
  final List<ApiOrder> orders;
  final List<ApiStorage> storages;
  final List<ApiProductArrival> productArrivals;
  final List<ApiProductArrivalPackageType> productArrivalPackageTypes;

  ApiData({
    required this.orders,
    required this.storages,
    required this.productArrivals,
    required this.productArrivalPackageTypes
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      orders: json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList(),
      storages: json['storages'].map<ApiStorage>((e) => ApiStorage.fromJson(e)).toList(),
      productArrivals: json['productArrivals'].map<ApiProductArrival>((e) => ApiProductArrival.fromJson(e)).toList(),
      productArrivalPackageTypes: json['productArrivalPackageTypes']
        .map<ApiProductArrivalPackageType>((e) => ApiProductArrivalPackageType.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
    orders,
    storages,
    productArrivals,
    productArrivalPackageTypes
  ];
}
