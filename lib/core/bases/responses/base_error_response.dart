
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

import '../../../domain/entities/enum/enum_mapper.dart';
part 'base_error_response.freezed.dart';
part 'base_error_response.g.dart';
@freezed
class BaseErrorResponse with _$BaseErrorResponse{
  const factory BaseErrorResponse({
    int? statusCode,
    String? message,
    @ApiErrorTypeConverter() ApiErrorType? errorType,
}) = _BaseErrorResponse;
  factory BaseErrorResponse.fromJson(Map<String, Object?> json) =>
      _$BaseErrorResponseFromJson(json);
}