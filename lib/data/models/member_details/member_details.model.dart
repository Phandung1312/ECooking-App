
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';
part 'member_details.model.freezed.dart';
part 'member_details.model.g.dart';
@freezed
class MemberDetailsModel with _$MemberDetailsModel{
  const MemberDetailsModel._();
  const factory MemberDetailsModel({
    required int id,
    String? displayName,
    String? username,
    String? avatarUrl,
    String? story,
    int? recipeCount,
    int? followingCount,
    int? followerCount,
    bool? isFollowing,
    int? totalViews,
    String? address,
    String? createdAt,
  }) = _MemberDetailsModel;
  factory MemberDetailsModel.fromJson(Map<String, dynamic> json) => _$MemberDetailsModelFromJson(json);
  MemberDetails mapToEntity(){
    return MemberDetails(
      id: id,
      displayName: displayName ?? '',
      username: username ?? '',
      avatarUrl: avatarUrl ?? '',
      story: story ?? '',
      recipeCount: recipeCount ?? 0,
      followingCount: followingCount ?? 0,
      followerCount: followerCount ?? 0,
      isFollowing: isFollowing ?? false,
      totalViews: totalViews ?? 0,
      address: address ?? '',
      createdAt: createdAt ?? '',
    );
  }
}