import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:uq_system_app/core/exceptions/network_exception.dart';
import 'package:uq_system_app/core/exceptions/unauthorized_exception.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:uq_system_app/data/sources/network/network_urls.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

import '../../../core/bases/responses/base_error_response.dart';

class ApiServices extends DioForNative implements Interceptor {
  final AuthServices _authServices;

  ApiServices._(this._authServices, BaseOptions options) : super(options);

  factory ApiServices({
    required AuthServices authRepository,
    required String baseUrl,
    Map<String, dynamic> headers = const {},
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      contentType: 'application/json; charset=utf-8',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(minutes: 5),
    );

    final instance = ApiServices._(
      authRepository,
      options,
    );

    instance.interceptors.add(instance);

    return instance;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final errorType = err.type;
    final statusCode = err.response?.statusCode;

    if (err.error is SocketException ||
        errorType == DioExceptionType.connectionTimeout ||
        errorType == DioExceptionType.receiveTimeout ||
        errorType == DioExceptionType.sendTimeout) {
      return handler.next(NetworkException());
    }

    if (statusCode == 401) {
      var baseError = BaseErrorResponse.fromJson(err.response?.data);
      if (baseError.errorType == ApiErrorType.accessTokenExpired) {
        final refreshToken = await _authServices.getRefreshToken();
        final accessToken = await _authServices.getAccessToken();
        if (refreshToken != null && accessToken != null) {
          final isRefreshed =
              await this.refreshToken(refreshToken, accessToken);
          if (isRefreshed) {
            return handler.resolve(await reTry(err.requestOptions));
          }
        }
      }
      return handler.next(UnauthorizedException());
    }
    return handler.next(err);
  }

  Future<Response> reTry(RequestOptions requestOption) async {
    final method = requestOption.method;
    if (method == 'PUT') {
      return await put(requestOption.path, data: requestOption.data);
    }
    if (method == 'GET') {
      return await get(requestOption.path,
          queryParameters: requestOption.queryParameters);
    }
    if (method == 'DELETE') {
      return await delete(requestOption.path, data: requestOption.data);
    }
    return await post(requestOption.path, data: requestOption.data);
  }

  Future<bool> refreshToken(String refreshToken, String accessToken) async {
    try {
      final response = await post(
        NetworkUrls.refresh,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }),
        data: {
          'refreshToken': refreshToken,
        },
      );
      final newAccessToken = response.data['data']?['accessToken'];
      await _authServices.saveAccessToken(newAccessToken);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<void> onRequest(
      RequestOptions originalOptions, RequestInterceptorHandler handler) async {
    final options = originalOptions.copyWith();
    if (NetworkUrls.requireAuthentication(options.path)) {
      options.headers =
          await _authServices.getAuthenticatedHeaders(options.headers);
    }
    options.headers =
        await _authServices.getAuthenticatedHeaders(options.headers);
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path.contains(NetworkUrls.login) &&
        response.data is Map) {
      final accessToken = response.data['data']?['accessToken'];
      await _authServices.saveAccessToken(accessToken);
      final refreshToken = response.data['data']?['refreshToken'];
      await _authServices.saveRefreshToken(refreshToken);
    }
    //TODO: clear access token when user logout app
    //   await _authServices.removeAllTokens();
    // }
    return handler.next(response);
  }

  void setLocale(language) {}
}
