import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/app/constants/strings.dart';
import '/app/entities/entities.dart';
import '/app/data/database.dart';

class Api {
  static const String authSchema = 'Renew';

  final AppDataStore dataStore;

  Api({
    required this.dataStore
  });

  Future<void> login({
    required String url,
    required String login,
    required String password
  }) async {
    Map<String, dynamic> result = await _sendRawRequest(() async {
      Dio dio = await _createDio(url, null);

      return await dio.post(
        'v2/authenticate',
        options: Options(headers: { 'Authorization': '$authSchema login=$login,password=$password' })
      );
    });

    ApiCredential apiCredential = ApiCredential(
      accessToken: result['access_token'],
      refreshToken: result['refresh_token'],
      url: url
    );

    await dataStore.apiCredentialsDao.updateApiCredential(apiCredential.toCompanion(true));
  }

  Future<void> refresh() async {
    ApiCredential apiCredential = await _getApiCredentials();
    Map<String, dynamic> result = await _sendRawRequest(() async {
      Dio dio = await _createDio(apiCredential.url, apiCredential.refreshToken);

      return await dio.post('v2/refresh');
    });

    ApiCredential newApiCredential = apiCredential.copyWith(
      accessToken: result['access_token'],
      refreshToken: result['refresh_token']
    );

    await dataStore.apiCredentialsDao.updateApiCredential(newApiCredential.toCompanion(true));
  }

  Future<void> logout() async {
    ApiCredential newApiCredential = ApiCredential(
      accessToken: '',
      refreshToken: '',
      url: ''
    );

    await dataStore.apiCredentialsDao.updateApiCredential(newApiCredential.toCompanion(true));
  }

  Future<ApiData> loadOrders() async {
    return ApiData.fromJson(await _sendRequest((dio) => dio.get('v1/logisto')));
  }

  Future<ApiOrder> findOrder({
    required String trackingNumber
  }) async {
    final orderData = await _sendRequest((dio) => dio.get(
      'v1/logisto/find_order',
      queryParameters: { 'trackingNumber': trackingNumber }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> updateOrder({
    required int id,
    required Map<String, dynamic> data
  }) async {
    final orderData = await _sendRequest((dio) => dio.put(
      'v1/logisto/update_order',
      data: data..addAll({ 'id': id })
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptOrder({
    required int id,
    required int storageId
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/accept_order',
      data: { 'id': id, 'storageId': storageId }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptStorageTransferOrder({
    required int id
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/accept_storage_transfer_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> acceptTransferOrder({
    required int id
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/accept_transfer_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> cancelOrder({
    required int id
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/cancel_order',
      data: { 'id': id }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> confirmOrder({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/confirm_order',
      data: { 'id': id, 'lines': lines }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiOrder> transferOrder({
    required int id,
    required int storageId
  }) async {
    final orderData = await _sendRequest((dio) => dio.post(
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
    final orderData = await _sendRequest((dio) => dio.post(
      'v1/logisto/accept_payment',
      data: {
        'id': id,
        'summ': summ,
        'paymentTransaction': transaction,
      }
    ));

    return ApiOrder.fromJson(orderData);
  }

  Future<ApiProductArrival> productArrivalsBeginUnload({
    required int id
  }) async {
    final productArrivalData = await _sendRequest((dio) => dio.post(
      'v1/logisto/product_arrivals/begin_unload',
      data: {
        'id': id
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsFinishUnload({
    required int id,
    required List<Map<String, dynamic>> packages
  }) async {
    final productArrivalData = await _sendRequest((dio) => dio.post(
      'v1/logisto/product_arrivals/finish_unload',
      data: {
        'id': id,
        'packages': packages
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsBeginPackageAccept({
    required int id
  }) async {
    final productArrivalData = await _sendRequest((dio) => dio.post(
      'v1/logisto/product_arrivals/begin_package_accept',
      data: {
        'id': id
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<ApiProductArrival> productArrivalsFinishPackageAccept({
    required int id,
    required List<Map<String, dynamic>> lines
  }) async {
    final productArrivalData = await _sendRequest((dio) => dio.post(
      'v1/logisto/product_arrivals/finish_package_accept',
      data: {
        'id': id,
        'lines': lines
      }
    ));

    return ApiProductArrival.fromJson(productArrivalData);
  }

  Future<List<ApiProduct>> productArrivalFindProduct({
    String? code,
    String? name
  }) async {
    final productData = await _sendRequest((dio) => dio.get(
      'v1/logisto/product_arrivals/find_product',
      queryParameters: { 'code': code, 'name': name }
    ));

    return productData.map<ApiProduct>((e) => ApiProduct.fromJson(e)).toList();
  }

  Future<void> resetPassword({
    required String url,
    required String login
  }) async {
    await _sendRawRequest(() async {
      Dio dio = await _createDio(url, null);

      return await dio.post(
        'v2/reset_password',
        options: Options(headers: { 'Authorization': '$authSchema login=$login' })
      );
    });
  }

  Future<ApiPaymentCredentials> getPaymentCredentials() async {
    return ApiPaymentCredentials.fromJson(await _sendRequest((dio) => dio.get('v1/logisto/credentials')));
  }

  Future<ApiUserData> getUserData() async {
    return ApiUserData.fromJson(await _sendRequest((dio) => dio.get('v1/logisto/user_info')));
  }

  Future<dynamic> _sendRequest(Future<dynamic> Function(Dio) request) async {
    ApiCredential apiCredential = await _getApiCredentials();

    try {
      return await _sendRawRequest(() async {
        Dio dio = await _createDio(apiCredential.url, apiCredential.accessToken);

        return await request.call(dio);
      });
    } on AuthException {
      await refresh();
      ApiCredential newApiCredential = await _getApiCredentials();
      Dio newDio = await _createDio(newApiCredential.url, newApiCredential.accessToken);

      return await _sendRawRequest(() async {
        return await request.call(newDio);
      });
    }
  }

  Future<dynamic> _sendRawRequest(Future<Response> Function() rawRequest) async {
    try {
      return (await rawRequest.call()).data;
    } on DioError catch(e) {
      _onDioError(e);
    }
  }

  Future<ApiCredential> _getApiCredentials() async {
    return await dataStore.apiCredentialsDao.getApiCredential();
  }

  Future<Dio> _createDio(String url, String? token) async {
    String version = (await PackageInfo.fromPlatform()).version;
    String appName = Strings.appName;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      appName: version,
      'Authorization': '$authSchema token=$token',
      HttpHeaders.userAgentHeader: '$appName/$version ${FkUserAgent.userAgent}',
    };

    return Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: headers,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
  }

  static void _onDioError(DioError e) {
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
      if (e.error is SocketException || e.error is HandshakeException || e.type == DioErrorType.connectTimeout) {
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
