import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/response/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthSignOutStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    Account? account,
    @Default(AuthSignOutStatus.initial) AuthSignOutStatus signOutStatus,
    BaseException? error,
  }) = _AuthState;
}
