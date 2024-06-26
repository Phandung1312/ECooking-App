import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_event.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_state.dart';

import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/enum/enum.dart';
import '../../../domain/entities/params/paginate_recipe.params.dart';
import '../../../domain/usecase/recipe/change_saved_recipe.usecase.dart';
import '../../../domain/usecase/recipe/get_recipes.usecase.dart';

@injectable
class ViewMoreRecipesBloc
    extends Bloc<ViewMoreRecipesEvent, ViewMoreRecipesState> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final GetRecipesUseCase _getRecipesUseCase;
  final ChangeSavedRecipeUseCase _changeSavedRecipeUseCase;

  ViewMoreRecipesBloc(this._getRecipesUseCase, this._changeSavedRecipeUseCase)
      : super(const ViewMoreRecipesState()) {
    on<ViewMoreRecipesErrorOccurred>(_onErrorOccurred);
    on<ViewMoreRecipesLoad>(_onLoad);
    on<ViewMoreRecipesChangeSavedRecipe>(_onChangeSavedRecipe);
  }

  FutureOr<void> _onLoad(
    ViewMoreRecipesLoad event,
    Emitter<ViewMoreRecipesState> emit,
  ) async {
    emit(state.copyWith(
        status: !event.isLoadMore
            ? ViewMoreRecipesStatus.loading
            : ViewMoreRecipesStatus.loadingMore,
        recipesPage: event.isLoadMore ? state.recipesPage : 1));
    final recipes = await _getRecipesUseCase(PaginateRecipeParams(
        page: state.recipesPage,
        perPage: 20,
        recipeSearchType: RecipeSearchType.POPULAR.name));
    if (event.isLoadMore) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
    emit(state.copyWith(
      recipes: event.isLoadMore ? [...state.recipes, ...recipes] : recipes,
      recipesPage:
          recipes.isNotEmpty ? state.recipesPage + 1 : state.recipesPage,
      status: ViewMoreRecipesStatus.success,
    ));
  }

  FutureOr<void> _onChangeSavedRecipe(
    ViewMoreRecipesChangeSavedRecipe event,
    Emitter<ViewMoreRecipesState> emit,
  ) async {
    var result = await _changeSavedRecipeUseCase(event.request);
    var recipes = state.recipes.map((e) {
      if (e.id == event.request.recipeId) {
        return e.copyWith(isSaved: !e.isSaved);
      }
      return e;
    }).toList();
    emit(state.copyWith(recipes: recipes, status: ViewMoreRecipesStatus.success));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(ViewMoreRecipesErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    ViewMoreRecipesErrorOccurred event,
    Emitter<ViewMoreRecipesState> emit,
  ) {
    if (refreshController.isLoading) refreshController.loadComplete();
    if (refreshController.isRefresh) refreshController.refreshCompleted();
    emit(state.copyWith(
      status: ViewMoreRecipesStatus.failure,
    ));
  }
}
