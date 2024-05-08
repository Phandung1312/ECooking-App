import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
part 'member.g.dart';
@freezed
class Member with _$Member {
  const factory Member({
    @Default(0) int id,
    @Default('') String displayName,
    @Default('') String avatarUrl,
    @Default(0) int recipeCount,
    @Default(0) int followingCount,
  }) = _Member;
  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);
}