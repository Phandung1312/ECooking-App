import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.errorOccurred([BaseException? error]) = HomeErrorOccurred;
  const factory HomeEvent.getTopMembers() = HomeGetTopMembers;
  const factory HomeEvent.getPopularRecipes() = HomeGetPopularRecipes;
  const factory HomeEvent.getNewestRecipes({required bool isLoadMore}) = HomeGetNewestRecipes;
  const factory HomeEvent.changeRecipeFavorite(RecipeFeatureRequest request) = HomeChangeRecipeFavorite;
  const factory HomeEvent.changeSavedRecipe({required RecipeFeatureRequest request,required RecipeSearchType type }) = HomeChangeSavedRecipe;
}
