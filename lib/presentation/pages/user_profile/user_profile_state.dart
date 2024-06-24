import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

import '../../../domain/entities/recipe.dart';

part 'user_profile_state.freezed.dart';

enum UserProfileStatus {
  initial,
  loadingProfile,
  loadingRecipes,
  loadedProfile,
  loadedRecipes,
  updating,
  updated,
  failure,
}

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(MemberDetails()) MemberDetails profile,
    @Default([]) List<Recipe> recipes,
    @Default(1) int currentRecipesPage,
    @Default(UserProfileStatus.initial) UserProfileStatus status,
    BaseException? error,
  }) = _UserProfileState;
}
