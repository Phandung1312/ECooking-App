import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_recipe_bloc.dart';
import 'create_recipe_state.dart';


class CreateRecipeStatusSelector
    extends BlocSelector<CreateRecipeBloc, CreateRecipeState, CreateRecipeStatus> {
  CreateRecipeStatusSelector({
    required Widget Function(CreateRecipeStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

class CreateRecipeStatusListener extends BlocListener<CreateRecipeBloc, CreateRecipeState> {
  CreateRecipeStatusListener({
    required Iterable<CreateRecipeStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
