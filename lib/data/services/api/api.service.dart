import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:uq_system_app/core/exceptions/network_exception.dart';
import 'package:uq_system_app/core/exceptions/unauthorized_exception.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:uq_system_app/data/sources/network/network_urls.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

import '../../../core/bases/responses/base_error_response.dart';
import '../../sources/network/network.dart';

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
  void onError(DioException err, ErrorInterceptorHandler handler) async{
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
      if(ApiErrorType.refreshTokenExpired == baseError.errorType){
        return handler.next(UnauthorizedException());
      }
      else if(baseError.errorType == ApiErrorType.accessTokenExpired){
         final networkDataSource = getIt.get<NetworkDataSource>();

         var refreshToken = await _authServices.getRefreshToken();
         final response = await networkDataSource.refreshToken(refreshToken ?? '');
          if(response.data != null){

          }
          else{
            return handler.next(UnauthorizedException());
          }
      }
    }
    return handler.next(err);
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
    }
    //TODO: clear access token when user logout app
    //   await _authServices.removeAllTokens();
    // }
    return handler.next(response);
  }

  void setLocale(language) {}
}
