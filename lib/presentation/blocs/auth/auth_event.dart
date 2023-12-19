import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/response/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loggedIn(Account account) = AuthLoggedIn;

  const factory AuthEvent.loggedOut([BaseException? error]) = AuthLoggedOut;
}
