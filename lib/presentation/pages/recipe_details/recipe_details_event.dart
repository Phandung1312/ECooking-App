import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'recipe_details_event.freezed.dart';

@freezed
class RecipeDetailsEvent with _$RecipeDetailsEvent {
  const factory RecipeDetailsEvent.errorOccurred([BaseException? error]) = RecipeDetailsErrorOccurred;
  const factory RecipeDetailsEvent.load(int recipeId) = RecipeDetailsLoad;
  const factory RecipeDetailsEvent.loadComments(int recipeId) = RecipeDetailsLoadComments;
  const factory RecipeDetailsEvent.loadSuggests(String title) = RecipeDetailsLoadSuggests;
}
