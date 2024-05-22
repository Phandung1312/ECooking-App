import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_state.dart';

class SearchStatusSelector
    extends BlocSelector<SearchBloc, SearchState, SearchStatus> {
  SearchStatusSelector({
    required Widget Function(SearchStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

class SearchSelector<T>
    extends BlocSelector<SearchBloc, SearchState, T> {
  SearchSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
    builder: (_, data) => builder(data),
  );
}

class SearchStatusListener extends BlocListener<SearchBloc, SearchState> {
  SearchStatusListener({
    required Iterable<SearchStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}
