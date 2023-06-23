import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';

class Api {
  static const String authSchema = 'Renew';
  static const _kAccessTokenKey = 'accessToken';
  static const _kRefreshTokenKey = 'refreshToken';
  static const _kUrlKey = 'url';
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true, resetOnError: true)
  );

  late Dio _dio;
  final String _version;
  String _refreshToken;
  String _url;
  String _accessToken;

  Api._(
    this._url,
    this._accessToken,
    this._refreshToken,
    this._version
  ) {
    _dio = _createDio(_url, _version, _accessToken);
  }

  Future<void> _setApiData(String url, String accessToken, String refreshToken) async {
    await _storage.write(key: _kUrlKey, value: url);
    await _storage.write(key: _kAccessTokenKey, value: accessToken);
    await _storage.write(key: _kRefreshTokenKey, value: refreshToken);

    _url = url;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _dio = _createDio(_url, _version, _accessToken);
  }

  static Future<Api> init() async {
    return Api._(
      await _storage.read(key: _kUrlKey) ?? '',
      await _storage.read(key: _kAccessTokenKey) ?? '',
      await _storage.read(key: _kRefreshTokenKey) ?? '',
      (await PackageInfo.fromPlatform()).version
    );
  }

  bool get isLoggedIn => _accessToken != '';

  Future<void> login({
    required String url,
    required String login,
    required String password
  }) async {
    await _setApiData(url, '', '');
    Map<String, dynamic> result = await _sendRawRequest(() => _dio.post(
      'v2/authenticate',
      options: Options(headers: { 'Authorization': '$authSchema login=$login,password=$password' })
    ));

    await _setApiData(url, result['access_token'], result['refresh_token']);
  }

  Future<void> refresh() async {
    await _setApiData(_url, _refreshToken, '');
    Map<String, dynamic> result = await _sendRawRequest(() => _dio.post('v2/refresh'));

    await _setApiData(_url, result['access_token'], result['refresh_token']);
  }

  Future<void> logout() async {
    await _setApiData('', '', '');
  }

  Future<void> resetPassword({
    required String url,
    required String login
  }) async {
    await _sendRawRequest(() async {
      _dio = _createDio(url, _version, null);

      return await _dio.post(
        'v2/reset_password',
        options: Options(headers: { 'Authorization': '$authSchema login=$login' })
      );
    });
  }

  Future<ApiData> loadData() async {
    return ApiData.fromJson(await _sendRequest(() => _dio.get('v1/logisto')));
  }

  Future<ApiOrder> findOrder({
    required String trackingNumber
  }) async {
    final orderData = await _sendRequest(() => _dio.get(
      'v1/logisto/find_order',
      queryParameters: { 'trackingNumber': trackingNumber }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> updateOrder({
    required int id,
    required Map<String, dynamic> data
  }) async {
    final orderData = await _sendRequest(() => _dio.put(
      'v1/logisto/update_order',
      data: data..addAll({ 'id': id })
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptOrder({
    required int id,
    required int storageId
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/accept_order',
      data: { 'id': id, 'storageId': storageId }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptStorageTransferOrder({
    required int id
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/accept_storage_transfer_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptTransferOrder({
    required int id
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/accept_transfer_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> cancelOrder({
    required int id
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/cancel_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> confirmOrder({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/confirm_order',
      data: { 'id': id, 'lines': lines }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> transferOrder({
    required int id,
    required int storageId
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/transfer_order',
      data: { 'id': id, 'storageId': storageId }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptPayment({
    required int id,
    required double summ,
    Map<dynamic, dynamic>? transaction
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/accept_payment',
      data: {
        'id': id,
        'summ': summ,
        'paymentTransaction': transaction,
      }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder>saveOrderLineCodes({
    required int id,
    required List<Map<String, dynamic>> codes
  }) async {
    final orderData = await _sendRequest(() => _dio.post(
      'v1/logisto/save_order_line_codes',
      data: {
        'id': id,
        'codes': codes
      }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiProductArrival> findProductArrival({
    required String number
  }) async {
    final orderData = await _sendRequest(() => _dio.get(
      'v1/logisto/product_arrivals/find_product_arrival',
      queryParameters: { 'number': number }
    ));

    return ApiProductArrival.fromJson(orderData);
  }

  Future<ApiProductArrival> productArrivalsBeginUnload({
    required int id,
    required int storageUnloadPointId
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/begin_unload',
      data: {
        'id': id,
        'storageUnloadPointId': storageUnloadPointId
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsFinishUnload({
    required int id,
    required List<Map<String, dynamic>> packages,
    required List<Map<String, dynamic>> unloadPackages
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/finish_unload',
      data: {
        'id': id,
        'packages': packages,
        'unloadPackages': unloadPackages
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsBeginPackageAccept({
    required int id,
    required int storageAcceptPointId
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/begin_package_accept',
      data: {
        'id': id,
        'storageAcceptPointId': storageAcceptPointId
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsFinishPackageAccept({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/finish_package_accept',
      data: {
        'id': id,
        'lines': lines
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsPlacePackageProducts({
    required int id,
    required List<Map<String, dynamic>> cells
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/place_package_products',
      data: {
        'id': id,
        'cells': cells
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsSavePackageCodes({
    required int id,
    required List<Map<String, dynamic>> codes
  }) async {
    final productArrivalData = await _sendRequest(() => _dio.post(
      'v1/logisto/product_arrivals/save_package_codes',
      data: {
        'id': id,
        'codes': codes
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<List<ApiProduct>> productsFindProduct({
    String? code,
    String? name
  }) async {
    final productData = await _sendRequest(() => _dio.get(
      'v1/logisto/products/find_product',
      queryParameters: { 'code': code, 'name': name }
    ));

    return productData.map<ApiProduct>((e) => ApiProduct.fromJson(e)).toList();
  }

  Future<void> productsTransfer({
    required int id,
    required String fromStore,
    required String toStore,
    required String? comment,
    required List<Map<String, dynamic>> fromCells,
    required List<Map<String, dynamic>> toCells,
  }) async {
    await _sendRequest(() => _dio.post(
      'v1/logisto/products/transfer',
      data: {
        'id': id,
        'fromStore': fromStore,
        'toStore': toStore,
        'comment': comment,
        'fromCells': fromCells,
        'toCells': toCells
      }
    ));
  }

  Future<List<ApiProductBarcode>> productBarcodes({
    required int productId
  }) async {
    final productBarcodeData = await _sendRequest(() => _dio.get(
      'v1/logisto/product_barcodes',
      queryParameters: { 'productId': productId }
    ));

    return productBarcodeData.map<ApiProductBarcode>((e) => ApiProductBarcode.fromJson(e)).toList();
  }

  Future<ApiProductBarcode> productBarcodesCreate({
    required int productId,
    required String type,
    required String code
  }) async {
    final productBarcode = await _sendRequest(() => _dio.post(
      'v1/logisto/product_barcodes',
      data: { 'productId': productId, 'type': type, 'code': code }
    ));

    return ApiProductBarcode.fromJson(productBarcode);
  }

  Future<List<ApiProductImage>> productImages({
    required int productId
  }) async {
    final productImageData = await _sendRequest(() => _dio.get(
      'v1/logisto/product_images',
      queryParameters: { 'productId': productId }
    ));

    return productImageData.map<ApiProductImage>((e) => ApiProductImage.fromJson(e)).toList();
  }

  Future<ApiProductImage> productImagesCreate({
    required int productId,
    required XFile file,
  }) async {
    Uint8List fileBytes = await file.readAsBytes();
    String filename = file.path.split('/').last;

    final productImage = await _sendRequest(() => _dio.post(
      'v1/logisto/product_images',
      data: FormData.fromMap({
        'productId': productId,
        'file': MultipartFile.fromBytes(fileBytes, filename: filename, contentType: MediaType('image', 'jpeg'))
      })
    ));

    return ApiProductImage.fromJson(productImage);
  }

  Future<ApiPaymentCredentials> getPaymentCredentials() async {
    return ApiPaymentCredentials.fromJson(await _sendRequest(() => _dio.get('v1/logisto/credentials')));
  }

  Future<ApiUserData> getUserData() async {
    return ApiUserData.fromJson(await _sendRequest(() => _dio.get('v1/logisto/user_info')));
  }

  Future<dynamic> _sendRequest(Future<Response> Function() request) async {
    try {
      return await _sendRawRequest(request);
    } on AuthException {
      await refresh();
      return await _sendRawRequest(request);
    }
  }

  Future<dynamic> _sendRawRequest(Future<Response> Function() rawRequest) async {
    try {
      return (await rawRequest.call()).data;
    } on DioException catch(e) {
      _onDioException(e);
    }
  }

  Dio _createDio(String url, String version, String? token) {
    String appName = Strings.appName;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      appName: version,
      'Authorization': '$authSchema token=$token',
      HttpHeaders.userAgentHeader: '$appName/$version ${FkUserAgent.userAgent}',
    };

    return Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 100000),
      receiveTimeout: const Duration(seconds: 100000),
      headers: headers,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
  }

  static void _onDioException(DioException e) {
    if (e.response != null) {
      final int statusCode = e.response!.statusCode!;
      final dynamic body = e.response!.data;

      if (statusCode < 200) {
        throw ApiException('Ошибка при получении данных', statusCode);
      }

      if (statusCode >= 500) {
        throw ServerException(statusCode);
      }

      if (statusCode == 401) {
        throw AuthException(body['error']);
      }

      if (statusCode == 410) {
        throw VersionException(body['error']);
      }

      if (statusCode >= 400) {
        throw ApiException(body['error'], statusCode);
      }
    } else {
      if (
        e.error is SocketException ||
        e.error is HandshakeException ||
        e.error is HttpException ||
        e.type == DioExceptionType.connectionTimeout
      ) {
        throw ApiConnException();
      }

      throw e;
    }
  }
}

class ApiException implements Exception {
  String errorMsg;
  int statusCode;

  ApiException(this.errorMsg, this.statusCode);
}

class AuthException extends ApiException {
  AuthException(errorMsg) : super(errorMsg, 401);
}

class ServerException extends ApiException {
  ServerException(statusCode) : super('Нет связи с сервером', statusCode);
}

class ApiConnException extends ApiException {
  ApiConnException() : super('Нет связи', 503);
}

class VersionException extends ApiException {
  VersionException(errorMsg) : super(errorMsg, 410);
}
