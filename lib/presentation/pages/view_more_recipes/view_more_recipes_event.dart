import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';

part 'view_more_recipes_event.freezed.dart';

@freezed
class ViewMoreRecipesEvent with _$ViewMoreRecipesEvent {
  const factory ViewMoreRecipesEvent.errorOccurred([BaseException? error]) = ViewMoreRecipesErrorOccurred;
  const factory ViewMoreRecipesEvent.load({required bool isLoadMore}) = ViewMoreRecipesLoad;
  const factory ViewMoreRecipesEvent.changeSavedRecipe(RecipeFeatureRequest request) = ViewMoreRecipesChangeSavedRecipe;
}
