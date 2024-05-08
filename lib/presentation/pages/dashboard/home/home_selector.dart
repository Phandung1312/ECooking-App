import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_state.dart';

class HomeSelector<T> extends BlocSelector<HomeBloc, HomeState, T> {
  HomeSelector(
      {required Widget Function(T data) builder, required super.selector})
      : super(
          builder: (_, data) => builder(data),
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

class HomeBuilder extends BlocBuilder<HomeBloc, HomeState> {
  HomeBuilder(
      {required Iterable<HomeStatus> statuses,
      super.key,
      required super.builder})
      : super(
          buildWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}
