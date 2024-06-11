import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus {
  initial,
  loading,
  sessionExpired,
  success,
  failure,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    BaseException? error,
  }) = _AuthState;
}
