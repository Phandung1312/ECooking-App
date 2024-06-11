
import 'package:freezed_annotation/freezed_annotation.dart';
part 'member_details.freezed.dart';
@freezed
class MemberDetails with _$MemberDetails{
  const factory MemberDetails({
    @Default(0) int id,
    @Default('') String displayName,
    @Default('') String username,
    @Default('') String avatarUrl,
    @Default('') String story,
    @Default(0) int recipeCount,
    @Default(0) int followingCount,
    @Default(0) int followerCount,
    @Default(0) int totalViews,
    @Default(false) bool isFollowing,
    @Default('') String address,
    @Default('') String createdAt,
}) = _MemberDetails;

}