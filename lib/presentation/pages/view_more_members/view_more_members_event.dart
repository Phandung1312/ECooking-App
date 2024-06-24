import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

part 'view_more_members_event.freezed.dart';

@freezed
class ViewMoreMembersEvent with _$ViewMoreMembersEvent {
  const factory ViewMoreMembersEvent.errorOccurred([BaseException? error]) = ViewMoreMembersErrorOccurred;
  const factory ViewMoreMembersEvent.load({required bool isLoadMore }) = ViewMoreMembersLoad;
  const factory ViewMoreMembersEvent.changeFollow(FollowParams followParams) = ViewMoreMembersChangeFollow;
}
