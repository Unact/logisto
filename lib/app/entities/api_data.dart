part of 'entities.dart';

class ApiData {
  List<ApiOrder> orders;
  List<ApiStorage> storages;
  List<ApiProductArrival> productArrivals;

  ApiData({
    required this.orders,
    required this.storages,
    required this.productArrivals
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      orders: json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList(),
      storages: json['storages'].map<ApiStorage>((e) => ApiStorage.fromJson(e)).toList(),
      productArrivals: json['productArrivals'].map<ApiProductArrival>((e) => ApiProductArrival.fromJson(e)).toList(),
    );
  }
}
