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

class FeatureStatusConverter implements JsonConverter<FeatureStatus, int> {
  const FeatureStatusConverter();

  @override
  FeatureStatus fromJson(int json) {
    switch (json) {
      case 1:
        return FeatureStatus.enable;
      case 0:
        return FeatureStatus.disable;
      default:
        return FeatureStatus.disable;
    }
  }

  @override
  int toJson(FeatureStatus object) {
    switch (object) {
      case FeatureStatus.enable:
        return 1;
      case FeatureStatus.disable:
        return 0;
      default:
        return 0;
    }
  }
}

class NotificationTypeConverter implements JsonConverter<NotificationType, int> {
  const NotificationTypeConverter();

  @override
  NotificationType fromJson(int json) {
    switch (json) {
      case 1:
        return NotificationType.like;
      case 2:
        return NotificationType.commentRecipe;
      case 3:
        return NotificationType.responseComment;
      case 4:
        return NotificationType.recipe;
      case 5:
        return NotificationType.save;
      case 6 :
        return NotificationType.follow;
      default:
        return NotificationType.recipe;
    }
  }

  @override
  int toJson(NotificationType object) {
    switch (object) {
      case NotificationType.like:
        return 1;
      case NotificationType.commentRecipe:
        return 2;
      case NotificationType.responseComment:
        return 3;
      case NotificationType.recipe:
        return 4;
      case NotificationType.save:
        return 5;
      case NotificationType.follow:
        return 6;
      default:
        return 4;
    }
  }
}