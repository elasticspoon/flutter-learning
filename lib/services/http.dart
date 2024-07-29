import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_flutter/services/user_auth.dart';

const authUrl =
    String.fromEnvironment('AUTH_URL', defaultValue: 'http://10.0.2.2:9191');

Dio getAuthEndpoint() {
  return Dio(BaseOptions(
    baseUrl: authUrl,
  ));
}

const apiUrl =
    String.fromEnvironment('API_URL', defaultValue: 'http://10.0.2.2:9090');

class JwtInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains('login')) {
      final authToken = HttpClient().auth.authToken;
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        err.response?.statusMessage == 'Unauthorized') {
      // err.response?.statusMessage == 'Unauthorized' &&
      // err.response?.requestOptions.path != null &&
      // !err.response!.requestOptions.path.contains('/public/login')) {
      print(err.response?.requestOptions.path);
      print(err.response?.requestOptions.headers);
      final didRefresh = await HttpClient().auth.refreshTokens();

      if (didRefresh) {
        return handler
            .resolve(await HttpClient().apiEndpoint.fetch(err.requestOptions));
      } else {
        HttpClient().auth.signOut();
      }
    }
    print(err.response?.statusCode);
    print(err.response?.statusMessage);
    return handler.next(err);
  }
}

Dio getApiEndpoint() {
  return Dio(BaseOptions(baseUrl: apiUrl, headers: {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  }))
    ..interceptors.add(JwtInterceptor());
}

class HttpClient {
  HttpClient._privateConstructor(this.auth)
      : apiEndpoint = getApiEndpoint(),
        authEndpoint = getAuthEndpoint();

  static HttpClient? _instance;
  final UserAuth auth;
  final Dio apiEndpoint;
  final Dio authEndpoint;

  static HttpClient initialize(UserAuth auth) {
    _instance ??= HttpClient._privateConstructor(auth);
    return _instance!;
  }

  factory HttpClient() {
    if (_instance == null) {
      throw Exception(
          'ApiEndpoint is not initialized. Call initialize() first.');
    }
    return _instance!;
  }
}
