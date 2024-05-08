import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    BaseException? error,
  }) = _ProfileState;
}
