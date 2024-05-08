import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'notification_state.freezed.dart';

enum NotificationStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationStatus.initial) NotificationStatus status,
    BaseException? error,
  }) = _NotificationState;
}
