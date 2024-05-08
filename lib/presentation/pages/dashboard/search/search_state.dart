import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

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
    @Default(SearchStatus.initial) SearchStatus status,
    BaseException? error,
  }) = _SearchState;
}
