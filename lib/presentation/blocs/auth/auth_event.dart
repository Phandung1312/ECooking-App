import 'package:uq_system_app/core/exceptions/exception.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.errorOccurred([BaseException? error]) = AuthErrorOccurred;
  const factory AuthEvent.login({required LoginType loginType}) = AuthLogin;
  const factory AuthEvent.sessionExpired() = AuthSessionExpired;
  const factory AuthEvent.loggedOut([BaseException? error]) = AuthLoggedOut;
}
