import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
@freezed
class Member with _$Member {
  const factory Member({
    @Default(0) int id,
    @Default('') String displayName,
    @Default('') String username,
    @Default('') String avatarUrl,
    @Default(0) int recipeCount,
    @Default(0) int followingCount,
    @Default(false) bool isFollowing,
  }) = _Member;

}