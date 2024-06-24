import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

part 'edit_profile_state.freezed.dart';

enum EditProfileStatus {
  initial,
  loading,
  updated,
  success,
  failure,
}

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(AccountRequest()) AccountRequest accountRequest,
    @Default(false) bool isDataValid,
    @Default(EditProfileStatus.initial) EditProfileStatus status,
    BaseException? error,
  }) = _EditProfileState;
}
