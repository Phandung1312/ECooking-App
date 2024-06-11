import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_state.dart';

import '../../../../domain/entities/enum/enum.dart';
import '../../../../domain/entities/params/common_paginate.params.dart';
import '../../../../domain/usecase/recipe/change_saved_recipe.usecase.dart';
import '../../../../domain/usecase/recipe/get_saved_recipes.usecase.dart';
import '../../../../domain/usecase/recipe/get_user_recipes.usecase.dart';
import '../../../../domain/usecase/user/get_member.usecase.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late RefreshController userRecipesController;
  late RefreshController savedRecipesController ;
  final GetMemberUseCase _getMemberUseCase;
  final GetUserRecipesUseCase _getUserRecipesUseCase;
  final GetSavedRecipesUseCase _getSavedRecipesUseCase;
  final ChangeSavedRecipeUseCase _changeSavedRecipeUseCase;

  ProfileBloc(this._getMemberUseCase, this._getUserRecipesUseCase, this._getSavedRecipesUseCase, this._changeSavedRecipeUseCase)
      : super(const ProfileState()) {
    on<ProfileErrorOccurred>(_onErrorOccurred);
    on<ProfileLoadProfile>(_onLoadProfile);
    on<ProfileLoadUserRecipes>(_onLoadRecipes);
    on<ProfileLoadSavedRecipes>(_onLoadSavedRecipes);
    on<ProfileUpdateUserId>(_onUpdateUserId);
    on<ProfileChangeSavedRecipe>(_onChangeSavedRecipe);
  }

  FutureOr<void> _onLoadProfile(
    ProfileLoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.loadingProfile,
    ));
    var result = await _getMemberUseCase(state.userId);
    emit(state.copyWith(
      profile: result,
      status: ProfileStatus.loadedProfile,
    ));
  }
  _onUpdateUserId(ProfileUpdateUserId event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      userId: event.userId,
    ));
  }
  Future<void> _onChangeSavedRecipe(
    ProfileChangeSavedRecipe event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.loadingSavedRecipes,
    ));
    await _changeSavedRecipeUseCase(event.request);
    var updatedSavedRecipe = state.savedRecipes.map((e) {
      if(e.id == event.request.recipeId) {
        return e.copyWith(isSaved: event.request.status == FeatureStatus.enable);
      }
      return e;
    }).toList();
    emit(state.copyWith(
      savedRecipes: updatedSavedRecipe,
      status: ProfileStatus.loadedSavedRecipes,
    ));
  }
  FutureOr<void> _onLoadSavedRecipes(
    ProfileLoadSavedRecipes event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.loadingSavedRecipes,
      currentSavedRecipesPage: event.isLoadMore ? state.currentSavedRecipesPage : 1,
    ));
    var result = await _getSavedRecipesUseCase(
        CommonPaginateParams(page: state.currentSavedRecipesPage, id: state.userId));
    if(event.isLoadMore) {
      savedRecipesController.loadComplete();
    } else {
      savedRecipesController.refreshCompleted();
    }
    emit(state.copyWith(
      savedRecipes: event.isLoadMore ? [...state.savedRecipes, ...result] : result,
      status: ProfileStatus.loadedSavedRecipes,
      currentSavedRecipesPage: result.isEmpty
          ? state.currentSavedRecipesPage
          : state.currentSavedRecipesPage + 1,
    ));
  }
  FutureOr<void> _onLoadRecipes(
    ProfileLoadUserRecipes event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.loadingUserRecipes,
      currentUserRecipesPage: event.isLoadMore ? state.currentUserRecipesPage : 1,
    ));
    var result = await _getUserRecipesUseCase(
        CommonPaginateParams(page: state.currentUserRecipesPage, id: state.userId));
    if(event.isLoadMore) {
      userRecipesController.loadComplete();
    } else {
      userRecipesController.refreshCompleted();
    }
    emit(state.copyWith(
      userRecipes: event.isLoadMore? [...state.userRecipes, ...result] : result,
      status: ProfileStatus.loadedUserRecipes,
      currentUserRecipesPage: result.isNotEmpty
          ? state.currentUserRecipesPage + 1
          : state.currentUserRecipesPage,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (userRecipesController.isLoading) {
      userRecipesController.loadComplete();
    }
    if (savedRecipesController.isLoading) {
      savedRecipesController.loadComplete();
    }
    if(savedRecipesController.isRefresh) {
      savedRecipesController.refreshCompleted();
    }
    if(userRecipesController.isRefresh) {
      userRecipesController.refreshCompleted();
    }
    add(ProfileErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    ProfileErrorOccurred event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(
      status: ProfileStatus.failure,
    ));
  }
}
