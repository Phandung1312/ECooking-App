
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'ingredient.dart';

import 'instruction.dart';
part 'recipe_details.freezed.dart';
@freezed
class RecipeDetails with _$RecipeDetails{
  const factory RecipeDetails({
    @Default(0) int id,
    @Default('') String imageUrl,
    @Default('') String title,
    @Default('') String content,
    @Default('') String cookTime,
    @Default('') String servers,
    @Default(0) int views,
    @Default(0) int likeCount,
    @Default(Account()) Account author,
    @Default('') String videoUrl,
    @Default('') String createdAt,
    @Default(<Instruction>[]) List<Instruction> instructions,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
    @Default(RecipeStatus.draft) RecipeStatus status,
  }) = _RecipeDetails;
}