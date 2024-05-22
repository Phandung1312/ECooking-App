import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_state.dart';

class CommentSelector<T>
    extends BlocSelector<CommentBloc, CommentState, T> {
  CommentSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class CommentBuilder<T>
extends BlocBuilder<CommentBloc, CommentState> {
CommentBuilder({
required Iterable<CommentStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class CommentStatusListener extends BlocListener<CommentBloc, CommentState> {
  CommentStatusListener({
    required Iterable<CommentStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
