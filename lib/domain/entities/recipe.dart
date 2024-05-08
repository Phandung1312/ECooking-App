import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/domain/entities/account.dart';
part 'recipe.freezed.dart';
part 'recipe.g.dart';
@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    @Default(0) int id,
    @Default("") String title,
    @Default("") String content,
    @Default(0) int views,
    @Default(0) int likeCount,
    @Default("") String cookTime,
    @Default("") String servers,
    @Default(0) int status,
    @Default(Account()) Account account,
    @Default("") String imageUrl,
    @Default(false)  bool isVideo,
    @Default("") String createdAt,
  }) = _Recipe;
  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);
}