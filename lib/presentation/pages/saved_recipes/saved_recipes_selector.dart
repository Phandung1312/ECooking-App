import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_bloc.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_state.dart';

class SavedRecipesSelector<T>
    extends BlocSelector<SavedRecipesBloc, SavedRecipesState, T> {
  SavedRecipesSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class SavedRecipesBuilder<T>
extends BlocBuilder<SavedRecipesBloc, SavedRecipesState> {
SavedRecipesBuilder({
required Iterable<SavedRecipesStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class SavedRecipesStatusListener extends BlocListener<SavedRecipesBloc, SavedRecipesState> {
  SavedRecipesStatusListener({
    required Iterable<SavedRecipesStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
