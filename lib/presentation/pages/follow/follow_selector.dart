import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_bloc.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_state.dart';

class FollowSelector<T>
    extends BlocSelector<FollowBloc, FollowState, T> {
  FollowSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class FollowBuilder<T>
extends BlocBuilder<FollowBloc, FollowState> {
FollowBuilder({
required Iterable<FollowStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class FollowStatusListener extends BlocListener<FollowBloc, FollowState> {
  FollowStatusListener({
    required Iterable<FollowStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
