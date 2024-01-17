import 'dart:async';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/entities/entities.dart';

extension LogistoApi on RenewApi {
  Future<ApiData> loadData() async {
    final result = await get('v1/logisto');

    return ApiData.fromJson(result);
  }

  Future<ApiOrder> findOrder({
    required String trackingNumber
  }) async {
    final result = await get('v1/logisto/find_order', queryParameters: { 'trackingNumber': trackingNumber });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> updateOrder({
    required int id,
    required Map<String, dynamic> data
  }) async {
    final result = await put('v1/logisto/update_order', dataGenerator: () => data..addAll({ 'id': id }));

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> acceptOrder({
    required int id,
    required int storageId
  }) async {
    final result = await post('/v1/logisto/accept_order', dataGenerator: () => { 'id': id, 'storageId': storageId });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> acceptStorageTransferOrder({
    required int id
  }) async {
    final result = await post('v1/logisto/accept_storage_transfer_order', dataGenerator: () => { 'id': id });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> acceptTransferOrder({
    required int id
  }) async {
    final result = await post('v1/logisto/accept_transfer_order', dataGenerator: () => { 'id': id });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> cancelOrder({
    required int id
  }) async {
    final result = await post('v1/logisto/cancel_order', dataGenerator: () => { 'id': id });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> confirmOrder({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final result = await post('/v1/logisto/confirm_order', dataGenerator: () => { 'id': id, 'lines': lines });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> transferOrder({
    required int id,
    required int storageId
  }) async {
    final result = await post('v1/logisto/transfer_order', dataGenerator: () => { 'id': id, 'storageId': storageId });

    return ApiOrder.fromJson(result);
  }

  Future<ApiOrder> acceptPayment({
    required int id,
    required double summ,
    Map<dynamic, dynamic>? transaction
  }) async {
    final orderData = await post('v1/logisto/accept_payment', dataGenerator: () => {
      'id': id,
      'summ': summ,
      'paymentTransaction': transaction,
    });

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder>saveOrderLineCodes({
    required int id,
    required List<Map<String, dynamic>> codes
  }) async {
    final result = await post('v1/logisto/save_order_line_codes', dataGenerator: () => {
      'id': id,
      'codes': codes
    });

    return ApiOrder.fromJson(result);
  }

  Future<ApiProductArrival> findProductArrival({
    required String number
  }) async {
    final result = await get(
      'v1/logisto/product_arrivals/find_product_arrival',
      queryParameters: { 'number': number }
    );

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsBeginUnload({
    required int id,
    required int storageUnloadPointId
  }) async {
    final result = await post('v1/logisto/product_arrivals/begin_unload', dataGenerator: () => {
      'id': id,
      'storageUnloadPointId': storageUnloadPointId
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsFinishUnload({
    required int id,
    required List<Map<String, dynamic>> packages,
    required List<Map<String, dynamic>> unloadPackages
  }) async {
    final result = await post('v1/logisto/product_arrivals/finish_unload', dataGenerator: () => {
      'id': id,
      'packages': packages,
      'unloadPackages': unloadPackages
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsBeginPackageAccept({
    required int id,
    required int storageAcceptPointId
  }) async {
    final result = await post('v1/logisto/product_arrivals/begin_package_accept', dataGenerator: () => {
      'id': id,
      'storageAcceptPointId': storageAcceptPointId
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsFinishPackageAccept({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final result = await post('v1/logisto/product_arrivals/finish_package_accept', dataGenerator: () => {
      'id': id,
      'lines': lines
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsPlacePackageProducts({
    required int id,
    required List<Map<String, dynamic>> cells
  }) async {
    final result = await post('v1/logisto/product_arrivals/place_package_products', dataGenerator: () => {
      'id': id,
      'cells': cells
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<ApiProductArrival> productArrivalsSavePackageCodes({
    required int id,
    required List<Map<String, dynamic>> codes
  }) async {
    final result = await post('v1/logisto/product_arrivals/save_package_codes', dataGenerator: () => {
      'id': id,
      'codes': codes
    });

    return ApiProductArrival.fromJson(result);
  }

  Future<List<ApiProduct>> productsFindProduct({
    String? code,
    String? name
  }) async {
    final result = await get('v1/logisto/products/find_product', queryParameters: { 'code': code, 'name': name });

    return result.map<ApiProduct>((e) => ApiProduct.fromJson(e)).toList();
  }

  Future<void> productsTransfer({
    required int id,
    required String fromStore,
    required String toStore,
    required String? comment,
    required List<Map<String, dynamic>> fromCells,
    required List<Map<String, dynamic>> toCells,
  }) async {
    await post('v1/logisto/products/transfer', dataGenerator: () => {
      'id': id,
      'fromStore': fromStore,
      'toStore': toStore,
      'comment': comment,
      'fromCells': fromCells,
      'toCells': toCells
    });
  }

  Future<List<ApiProductBarcode>> productBarcodes({
    required int productId
  }) async {
    final result = await get('v1/logisto/product_barcodes', queryParameters: { 'productId': productId });

    return result.map<ApiProductBarcode>((e) => ApiProductBarcode.fromJson(e)).toList();
  }

  Future<ApiProductBarcode> productBarcodesCreate({
    required int productId,
    required String type,
    required String code
  }) async {
    final result = await post('v1/logisto/product_barcodes', dataGenerator: () => {
      'productId': productId,
      'type': type,
      'code': code
    });

    return ApiProductBarcode.fromJson(result);
  }

  Future<List<ApiProductImage>> productImages({
    required int productId
  }) async {
    final result = await get('v1/logisto/product_images', queryParameters: { 'productId': productId });

    return result.map<ApiProductImage>((e) => ApiProductImage.fromJson(e)).toList();
  }

  Future<ApiProductImage> productImagesCreate({
    required int productId,
    required XFile file,
  }) async {
    Uint8List fileBytes = await file.readAsBytes();
    String filename = file.path.split('/').last;
    final result = await post(
      'v1/logisto/product_images',
      dataGenerator: () => FormData.fromMap({
        'productId': productId,
        'file': MultipartFile.fromBytes(fileBytes, filename: filename, contentType: MediaType('image', 'jpeg'))
      })
    );

    return ApiProductImage.fromJson(result);
  }

  Future<ApiPaymentCredentials> getPaymentCredentials() async {
    final result = await get('v1/logisto/credentials');

    return ApiPaymentCredentials.fromJson(result);
  }

  Future<ApiUserData> getUserData() async {
    final result = await get('v1/logisto/user_info');

    return ApiUserData.fromJson(result);
  }
}
