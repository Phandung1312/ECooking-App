

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/data/models/recipe/recipe.model.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/enum/enum_mapper.dart';
import 'package:uq_system_app/domain/entities/notification.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/entities/recipe.dart';
part 'notification.model.freezed.dart';
part 'notification.model.g.dart';
@freezed
class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required int id,
    @NotificationTypeConverter() required NotificationType type,
    String? createdAt,
    int? status,
    RecipeModel? recipe,
    int? commentId,
    AccountResponse? sourceUser,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Notification mapToEntity(){
    return Notification(
      id: id,
      type: type,
      createdAt: createdAt ?? '',
      isRead: (status ?? 0) == 1 ? true : false,
      recipe: recipe?.mapToEntity() ?? const Recipe(),
      commentId: commentId ?? 0,
      sender: sourceUser?.mapToEntity() ?? const  Account(),
    );
  }
}