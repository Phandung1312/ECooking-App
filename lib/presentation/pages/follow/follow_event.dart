import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

import '../../../domain/entities/enum/enum.dart';

part 'follow_event.freezed.dart';

@freezed
class FollowEvent with _$FollowEvent {
  const factory FollowEvent.errorOccurred([BaseException? error]) = FollowErrorOccurred;
  const factory FollowEvent.updateUserId({required int userId}) = FollowUpdateUserId;
  const factory FollowEvent.loadFollowings({required bool isLoadMore}) = FollowLoadFollowings;
  const factory FollowEvent.loadFollowers({required bool isLoadMore}) = FollowLoadFollowers;
  const factory FollowEvent.updateFollow({required FollowParams params, required FollowType type}) = FollowUpdateFollow;
}
