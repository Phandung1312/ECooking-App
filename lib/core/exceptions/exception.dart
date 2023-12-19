import 'package:dio/dio.dart';
import 'package:uq_system_app/core/exceptions/unknown_exception.dart';

abstract class BaseException<T> extends DioException implements Exception {
  @override
  final String message;

  final String? code;

  final T? data;

  BaseException(
    this.message, {
    this.code,
    this.data,
    super.response,
    super.stackTrace,
    super.type,
    RequestOptions? requestOptions,
  }) : super(
          error: data,
          requestOptions: requestOptions ?? RequestOptions(path: ''),
        );

  static BaseException from(Object? error) {
    return error is BaseException ? error : UnknownException(error);
  }

  @override
  String toString() {
    return '$runtimeType'
        '('
        'message: $message'
        '${code != null ? ', code: $code' : ''}'
        '${data != null ? ', data: $data' : ''}'
        ')';
  }
}
