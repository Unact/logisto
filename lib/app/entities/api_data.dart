part of 'entities.dart';

class ApiData {
  List<ApiOrder> orders;
  List<ApiOrderStorage> orderStorages;

  ApiData({
    required this.orders,
    required this.orderStorages
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      orders: json['orders'].map<ApiOrder>((e) => ApiOrder.fromJson(e)).toList(),
      orderStorages: json['orderStorages'].map<ApiOrderStorage>((e) => ApiOrderStorage.fromJson(e)).toList(),
    );
  }
}
