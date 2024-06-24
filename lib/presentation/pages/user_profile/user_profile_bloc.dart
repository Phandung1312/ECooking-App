import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/usecase/user/update_follow.usecase.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_event.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/enum/enum.dart';
import '../../../domain/usecase/recipe/change_saved_recipe.usecase.dart';
import '../../../domain/usecase/recipe/get_user_recipes.usecase.dart';
import '../../../domain/usecase/user/get_member.usecase.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetMemberUseCase _getMemberUseCase;
  final GetUserRecipesUseCase _getUserRecipesUseCase;
  final UpdateFollowUseCase _updateFollowUseCase;
  late RefreshController refreshController;
  final ChangeSavedRecipeUseCase _changeSavedRecipeUseCase;

  UserProfileBloc(this._getMemberUseCase, this._getUserRecipesUseCase,
      this._updateFollowUseCase, this._changeSavedRecipeUseCase)
      : super(const UserProfileState()) {
    on<UserProfileErrorOccurred>(_onErrorOccurred);
    on<UserProfileLoadProfile>(_onLoadProfile);
    on<UserProfileLoadUserRecipes>(_onLoadRecipes);
    on<UserProfileChangeFollow>(_onChangeFollow);
    on<UserProfileChangeSavedRecipe>(_onChangeSavedRecipe);
  }

  FutureOr<void> _onChangeFollow(
    UserProfileChangeFollow event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: UserProfileStatus.updating,
    ));
    await _updateFollowUseCase(event.followParams);
    emit(state.copyWith(
      profile: state.profile.copyWith(
        isFollowing: !state.profile.isFollowing,
        followerCount: state.profile.isFollowing
            ? state.profile.followerCount - 1
            : state.profile.followerCount + 1,
      ),
      status: UserProfileStatus.updated,
    ));
  }

  FutureOr<void> _onLoadProfile(
    UserProfileLoadProfile event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: UserProfileStatus.loadingProfile,
    ));
    var result = await _getMemberUseCase(event.userId);
    emit(state.copyWith(
      profile: result,
      status: UserProfileStatus.loadedProfile,
    ));
  }

  FutureOr<void> _onLoadRecipes(
    UserProfileLoadUserRecipes event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: UserProfileStatus.loadingRecipes,
      currentRecipesPage: event.isLoadMore ? state.currentRecipesPage : 1,
    ));
    var result = await _getUserRecipesUseCase(
        CommonPaginateParams(page: state.currentRecipesPage, id: event.userId));
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    emit(state.copyWith(
      recipes: [...state.recipes, ...result],
      status: UserProfileStatus.loadedRecipes,
      currentRecipesPage: result.isNotEmpty
          ? state.currentRecipesPage + 1
          : state.currentRecipesPage,
    ));
  }

  FutureOr<void> _onChangeSavedRecipe(
    UserProfileChangeSavedRecipe event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: UserProfileStatus.loadingRecipes,
    ));
    await _changeSavedRecipeUseCase(event.request);
    var updatedRecipes = state.recipes.map((e) {
      if (e.id == event.request.recipeId) {
        return e.copyWith(
            isSaved: event.request.status == FeatureStatus.enable);
      }
      return e;
    }).toList();
    emit(state.copyWith(
      recipes: updatedRecipes,
      status: UserProfileStatus.loadedRecipes,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    add(UserProfileErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    UserProfileErrorOccurred event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(
      status: UserProfileStatus.failure,
    ));
  }
}
