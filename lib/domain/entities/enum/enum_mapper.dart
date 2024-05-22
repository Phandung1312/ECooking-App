import 'package:json_annotation/json_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

class ApiErrorTypeConverter implements JsonConverter<ApiErrorType, String> {
  const ApiErrorTypeConverter();

  @override
  ApiErrorType fromJson(String json) {
    switch (json) {
      case 'REFRESH_TOKEN_EXPIRED':
        return ApiErrorType.refreshTokenExpired;
      case 'ACCESS_TOKEN_EXPIRED':
        return ApiErrorType.accessTokenExpired;
      default:
        return ApiErrorType.unknown;
    }
  }

  @override
  String toJson(ApiErrorType object) {
    return "";
  }
}

class RecipeStatusConverter implements JsonConverter<RecipeStatus, int> {
  const RecipeStatusConverter();

  @override
  RecipeStatus fromJson(int json) {
    switch (json) {
      case 1:
        return RecipeStatus.draft;
      case 2:
        return RecipeStatus.public;
      case 0:
        return RecipeStatus.block;
      default:
        return RecipeStatus.draft;
    }
  }

  @override
  int toJson(RecipeStatus object) {
    switch (object) {
      case RecipeStatus.draft:
        return 1;
      case RecipeStatus.public:
        return 2;
      case RecipeStatus.block:
        return 0;
      default:
        return 1;
    }
  }
}
