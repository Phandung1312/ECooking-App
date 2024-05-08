import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_state.dart';

class ViewMoreRecipesSelector<T>
    extends BlocSelector<ViewMoreRecipesBloc, ViewMoreRecipesState, T> {
  ViewMoreRecipesSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class ViewMoreRecipesBuilder extends BlocBuilder<ViewMoreRecipesBloc, ViewMoreRecipesState> {
  ViewMoreRecipesBuilder(
      {required Iterable<ViewMoreRecipesStatus> statuses,
        super.key,
        required super.builder})
      : super(
    buildWhen: (previousState, currentState) =>
    previousState.status != currentState.status &&
        statuses.contains(currentState.status),
  );
}
class ViewMoreRecipesStatusListener extends BlocListener<ViewMoreRecipesBloc, ViewMoreRecipesState> {
  ViewMoreRecipesStatusListener({
    required Iterable<ViewMoreRecipesStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
