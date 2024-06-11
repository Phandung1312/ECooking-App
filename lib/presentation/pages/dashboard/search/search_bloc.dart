import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_state.dart';

import '../../../../domain/usecase/search/get_suggestions.usecase.dart';
import '../../../../domain/usecase/search/search.usecase.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSuggestionsUseCase _getSuggestRecipesUseCase;
  final SearchUseCase _searchUseCase;
  late RefreshController recipeController;
  late RefreshController accountController;
  late RefreshController instructionController;

  SearchBloc(this._getSuggestRecipesUseCase, this._searchUseCase)
      : super(const SearchState()) {
    on<SearchErrorOccurred>(_onErrorOccurred);
    on<SearchGetSuggestions>(_onGetSuggestions);
    on<SearchGetResult>(_onGetResult);
  }

  FutureOr<void> _onGetSuggestions(
      SearchGetSuggestions event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      status: SearchStatus.loading,
    ));
    final suggestions = await _getSuggestRecipesUseCase(event.keyword);
    emit(state.copyWith(
      suggestions: suggestions,
      status: SearchStatus.success,
    ));
  }

  FutureOr<void> _onGetResult(
      SearchGetResult event, Emitter<SearchState> emit) async {
    if (event.isRefresh) {
      emit(state.copyWith(
        status: SearchStatus.loading,
      ));
    }
    try {
      final searchResult = await _searchUseCase(event.params);

      if (event.isRefresh) {
        emit(state.copyWith(
          searchResult: searchResult,
          currentRecipePage: 2,
          currentAccountPage: 2,
          currentInstructionPage: 2,
          currentQuery: event.params.title,
          status: SearchStatus.success,
        ));
      } else {
        if (recipeController.isLoading) recipeController.loadComplete();
        if (accountController.isLoading) accountController.loadComplete();
        if (instructionController.isLoading) {
          instructionController.loadComplete();
        }
        emit(state.copyWith(
          searchResult: state.searchResult.copyWith(
            recipes: [...state.searchResult.recipes, ...searchResult.recipes],
            accounts: [
              ...state.searchResult.accounts,
              ...searchResult.accounts
            ],
            instructions: [
              ...state.searchResult.instructions,
              ...searchResult.instructions
            ],
          ),
          currentRecipePage: event.params.type == SearchType.recipe
              ? state.currentRecipePage + 1
              : state.currentRecipePage,
          currentAccountPage: event.params.type == SearchType.account
              ? state.currentAccountPage + 1
              : state.currentAccountPage,
          currentInstructionPage: event.params.type == SearchType.instruction
              ? state.currentInstructionPage + 1
              : state.currentInstructionPage,
          status: SearchStatus.success,
        ));
      }
    } catch (error) {
      if (!event.isRefresh) {
        if (recipeController.isLoading) recipeController.loadComplete();
        if (recipeController.isRefresh) recipeController.refreshCompleted();
        if (accountController.isLoading) accountController.loadComplete();
        if (accountController.isRefresh) accountController.refreshCompleted();
        if (instructionController.isLoading) {
          instructionController.loadComplete();
        }
        if (instructionController.isRefresh) {
          instructionController.refreshCompleted();
        }
      }
      add(SearchErrorOccurred(BaseException.from(error)));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(SearchErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    SearchErrorOccurred event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(
      status: SearchStatus.failure,
    ));
  }
}
