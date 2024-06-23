import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';
import 'package:uq_system_app/domain/entities/params/suggest_recipe.params.dart';

part 'recipe_details_event.freezed.dart';

@freezed
class RecipeDetailsEvent with _$RecipeDetailsEvent {
  const factory RecipeDetailsEvent.errorOccurred([BaseException? error]) = RecipeDetailsErrorOccurred;
  const factory RecipeDetailsEvent.load(int recipeId) = RecipeDetailsLoad;
  const factory RecipeDetailsEvent.loadComments(int recipeId) = RecipeDetailsLoadComments;
  const factory RecipeDetailsEvent.loadSuggests(SuggestRecipeParams params) = RecipeDetailsLoadSuggests;
  const factory RecipeDetailsEvent.changeFavorite() = RecipeDetailsChangeFavorite;
  const factory RecipeDetailsEvent.changeSaved() = RecipeDetailsChangeSaved;
  const factory RecipeDetailsEvent.changeFollow(FollowParams params) = RecipeDetailsChangeFollow;
  const factory RecipeDetailsEvent.delete() = RecipeDetailsDelete;
  const factory RecipeDetailsEvent.report(String content) = RecipeDetailsReport;
}
