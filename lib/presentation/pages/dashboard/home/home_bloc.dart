import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/usecase/recipe/get_recipes.usecase.dart';
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart';

import '../../../../domain/entities/params/common_paginate.params.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final GetRecipesUseCase _getRecipesUseCase;
  final GetTopMembersUseCase _getTopMembersUseCase;

  HomeBloc(this._getRecipesUseCase, this._getTopMembersUseCase)
      : super(const HomeState()) {
    on<HomeErrorOccurred>(_onErrorOccurred);
    on<HomeGetPopularRecipes>(_onGetPopularRecipes);
    on<HomeGetNewestRecipes>(_onGetNewestRecipes);
    on<HomeGetTopMembers>(_onGetTopMembers);
  }
  FutureOr<void> _onGetPopularRecipes(
    HomeGetPopularRecipes event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.loadingPopularRecipes,
    ));

    final recipes = await _getRecipesUseCase(PaginateRecipeParams(
        page: 1, perPage: 10, recipeSearchType: RecipeSearchType.POPULAR.name));
    emit(state.copyWith(
      popularRecipes: recipes,
      status: HomeStatus.loadedPopularRecipes,
    ));
  }

  FutureOr<void> _onGetTopMembers(
    HomeGetTopMembers event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.loadingTopMembers,
    ));
    final topMembers = await _getTopMembersUseCase(
        const CommonPaginateParams(page: 1, perPage: 5));
    emit(state.copyWith(
      topMembers: topMembers,
      status: HomeStatus.loadedTopMembers,
    ));
  }

  FutureOr<void> _onGetNewestRecipes(
    HomeGetNewestRecipes event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: !event.isLoadMore ? HomeStatus.loadingNewestRecipes : HomeStatus.loadingMore,
    ));
    final recipes = await _getRecipesUseCase(PaginateRecipeParams(
        page: state.newestRecipesPage,
        perPage: 10,
        recipeSearchType: RecipeSearchType.NEWEST.name));
    if(event.isLoadMore) refreshController.loadComplete();
    emit(state.copyWith(
      newestRecipes: [...state.newestRecipes, ...recipes],
      newestRecipesPage: state.newestRecipesPage + 1,
      status: HomeStatus.loadedNewestRecipes,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // add(HomeErrorOccurred(e));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    HomeErrorOccurred event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      status: HomeStatus.failure,
    ));
  }
}
