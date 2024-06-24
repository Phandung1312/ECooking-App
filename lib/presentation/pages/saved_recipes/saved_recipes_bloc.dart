import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_event.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/usecase/recipe/get_draft_recipes.usecase.dart';
@injectable
class SavedRecipesBloc extends Bloc<SavedRecipesEvent, SavedRecipesState> {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final GetDraftRecipesUseCase _getDraftRecipesUseCase;
  SavedRecipesBloc(this._getDraftRecipesUseCase) : super(const SavedRecipesState()) {
    on<SavedRecipesErrorOccurred>(_onErrorOccurred);
    on<SavedRecipesLoadDraftRecipes>(_onLoadDraftRecipes);
  }
  FutureOr<void> _onLoadDraftRecipes(
    SavedRecipesLoadDraftRecipes event,
    Emitter<SavedRecipesState> emit,
  ) async {
    emit(state.copyWith(
      status: SavedRecipesStatus.loading,
    ));
    final result = await _getDraftRecipesUseCase.call(const CommonPaginateParams(page: 1, perPage: 20));
    if(refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
    emit(state.copyWith(
      status : SavedRecipesStatus.success,
      draftRecipes: result,
    ));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    if(refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
    add(SavedRecipesErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    SavedRecipesErrorOccurred event,
    Emitter<SavedRecipesState> emit,
  ) {
    emit(state.copyWith(
      status: SavedRecipesStatus.failure,
    ));
  }
}
