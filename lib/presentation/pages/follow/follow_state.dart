import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

import '../../../domain/entities/member.dart';

part 'follow_state.freezed.dart';

enum FollowStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class FollowState with _$FollowState {
  const factory FollowState({
    @Default(0) int userId,
    @Default(1) int currentFollowersPage,
    @Default(1) int currentFollowingsPage,
    @Default([]) List<Member> followers,
    @Default([]) List<Member> followings,
    @Default(FollowStatus.initial) FollowStatus status,
    BaseException? error,
  }) = _FollowState;
}
