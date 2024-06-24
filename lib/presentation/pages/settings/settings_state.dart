import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'settings_state.freezed.dart';

enum SettingsStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.initial) SettingsStatus status,
    BaseException? error,
  }) = _SettingsState;
}
