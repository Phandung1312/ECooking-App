import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'notification_settings_state.freezed.dart';

enum NotificationSettingsStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState({
    @Default(NotificationSettingsStatus.initial) NotificationSettingsStatus status,
    BaseException? error,
  }) = _NotificationSettingsState;
}
