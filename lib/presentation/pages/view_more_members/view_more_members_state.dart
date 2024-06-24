import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

import '../../../domain/entities/member.dart';

part 'view_more_members_state.freezed.dart';

enum ViewMoreMembersStatus {
  initial,
  loading,
  loadingMore,
  updating,
  updated,
  success,
  failure,
}

@freezed
class ViewMoreMembersState with _$ViewMoreMembersState {
  const factory ViewMoreMembersState({
    @Default(1) int page,
    @Default([]) List<Member> members,
    @Default(ViewMoreMembersStatus.initial) ViewMoreMembersStatus status,
    BaseException? error,
  }) = _ViewMoreMembersState;
}
