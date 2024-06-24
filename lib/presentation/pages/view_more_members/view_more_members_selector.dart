import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_state.dart';

class ViewMoreMembersSelector<T>
    extends BlocSelector<ViewMoreMembersBloc, ViewMoreMembersState, T> {
  ViewMoreMembersSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class ViewMoreMembersBuilder<T>
extends BlocBuilder<ViewMoreMembersBloc, ViewMoreMembersState> {
ViewMoreMembersBuilder({
required Iterable<ViewMoreMembersStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class ViewMoreMembersStatusListener extends BlocListener<ViewMoreMembersBloc, ViewMoreMembersState> {
  ViewMoreMembersStatusListener({
    required Iterable<ViewMoreMembersStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
