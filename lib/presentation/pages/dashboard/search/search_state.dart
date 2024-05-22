import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/search_result.dart';

part 'search_state.freezed.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(1) int currentRecipePage,
    @Default(1) int currentAccountPage,
    @Default(1) int currentInstructionPage,
    @Default('') String currentQuery,
    @Default([]) List<String> suggestions,
    @Default(SearchResult()) SearchResult searchResult,
    @Default(SearchStatus.initial) SearchStatus status,
    BaseException? error,
  }) = _SearchState;
}
