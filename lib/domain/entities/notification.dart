
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
part 'notification.freezed.dart';
@freezed
class Notification with _$Notification {
  const factory Notification({
    @Default(0) int id,
    @Default(NotificationType.recipe) NotificationType type,
    @Default('') String createdAt,
    @Default(false) bool isRead,
    @Default(Recipe()) Recipe recipe,
    @Default(0) commentId,
    @Default(Account()) Account sender,
  }) = _Notification;


}