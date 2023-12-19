import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeStatusSelector extends BlocSelector<HomeBloc, HomeState, HomeStatus> {
  HomeStatusSelector({
    super.key,
    required Widget Function(HomeStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

class HomeStatusListener extends BlocListener<HomeBloc, HomeState> {
  HomeStatusListener({
    required Iterable<HomeStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}
