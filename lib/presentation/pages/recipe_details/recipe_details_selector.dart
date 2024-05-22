import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_bloc.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_state.dart';

class RecipeDetailsSelector<T>
    extends BlocSelector<RecipeDetailsBloc, RecipeDetailsState, T> {
  RecipeDetailsSelector(
      {required Widget Function(T data) builder, required super.selector})
      : super(
          builder: (_, data) => builder(data),
        );
}

class RecipeDetailsBuilder<T>
    extends BlocBuilder<RecipeDetailsBloc, RecipeDetailsState> {
  RecipeDetailsBuilder(
      {required Iterable<RecipeDetailsStatus> statuses,
      super.key,
      required super.builder})
      : super(
          buildWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}

class RecipeDetailsStatusListener
    extends BlocListener<RecipeDetailsBloc, RecipeDetailsState> {
  RecipeDetailsStatusListener({
    required Iterable<RecipeDetailsStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}
