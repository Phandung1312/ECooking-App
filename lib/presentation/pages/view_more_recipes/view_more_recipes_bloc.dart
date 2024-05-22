import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_event.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_state.dart';

import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/enum/enum.dart';
import '../../../domain/entities/params/paginate_recipe.params.dart';
import '../../../domain/usecase/recipe/get_recipes.usecase.dart';

@injectable
class ViewMoreRecipesBloc
    extends Bloc<ViewMoreRecipesEvent, ViewMoreRecipesState> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final GetRecipesUseCase _getRecipesUseCase;

  ViewMoreRecipesBloc(this._getRecipesUseCase)
      : super(const ViewMoreRecipesState()) {
    on<ViewMoreRecipesErrorOccurred>(_onErrorOccurred);
    on<ViewMoreRecipesLoad>(_onLoad);
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
      recipesPage: state.recipesPage + 1,
      status: ViewMoreRecipesStatus.success,
    ));
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
