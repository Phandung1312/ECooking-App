import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'account_state.freezed.dart';

enum AccountStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    @Default(AccountStatus.initial) AccountStatus status,
    BaseException? error,
  }) = _AccountState;
}
