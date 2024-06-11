
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/member.dart';
part 'member.model.freezed.dart';
part 'member.model.g.dart';
@freezed
class MemberModel with _$MemberModel{
  const MemberModel._();
  const factory MemberModel({
    required int id,
    String? displayName,
    String? username,
    String? avatarUrl,
    int? recipeCount,
    int? followingCount,
    bool? isFollowing,

  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Member mapToEntity(){
    return Member(
      id: id,
      displayName: displayName ?? "",
      username: username ?? "",
      avatarUrl: avatarUrl ?? "",
      recipeCount: recipeCount ?? 0,
      followingCount: followingCount ?? 0,
      isFollowing: isFollowing ?? false,
    );
  }
}