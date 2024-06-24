import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

import '../../../data/models/recipe_feature/recipe_feature.request.dart';

part 'user_profile_event.freezed.dart';

@freezed
class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.errorOccurred([BaseException? error]) = UserProfileErrorOccurred;
  const factory UserProfileEvent.loadProfile(int userId) = UserProfileLoadProfile;
  const factory UserProfileEvent.loadUserRecipes({required int userId, required bool isLoadMore}) = UserProfileLoadUserRecipes;
  const factory UserProfileEvent.changeFollow(FollowParams followParams) = UserProfileChangeFollow;
  const factory UserProfileEvent.changeSavedRecipe({required RecipeFeatureRequest request}) = UserProfileChangeSavedRecipe;
}
