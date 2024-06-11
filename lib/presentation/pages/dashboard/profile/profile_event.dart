import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.errorOccurred([BaseException? error]) = ProfileErrorOccurred;
  const factory ProfileEvent.updateUserId({required int userId}) = ProfileUpdateUserId;
  const factory ProfileEvent.loadProfile() = ProfileLoadProfile;
  const factory ProfileEvent.loadUserRecipes({required bool isLoadMore}) = ProfileLoadUserRecipes;
  const factory ProfileEvent.loadSavedRecipes({ required bool isLoadMore}) = ProfileLoadSavedRecipes;
  const factory ProfileEvent.changeSavedRecipe({required RecipeFeatureRequest request}) = ProfileChangeSavedRecipe;
}
