import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

import '../../../../domain/entities/recipe.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus {
  initial,
  loadingProfile,
  loadingUserRecipes,
  loadingSavedRecipes,
  loadedProfile,
  loadedUserRecipes,
  loadedSavedRecipes,
  success,
  failure,
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(0) int userId,
    @Default(MemberDetails()) MemberDetails profile,
    @Default([]) List<Recipe> userRecipes,
    @Default(1) int currentUserRecipesPage,
    @Default([]) List<Recipe> savedRecipes,
    @Default(1) int currentSavedRecipesPage,
    @Default(ProfileStatus.initial) ProfileStatus status,
    BaseException? error,
  }) = _ProfileState;
}
