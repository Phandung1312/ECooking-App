import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_bloc.dart';
import 'notification_state.dart';


class NotificationStatusSelector
    extends BlocSelector<NotificationBloc, NotificationState, NotificationStatus> {
  NotificationStatusSelector({
    required Widget Function(NotificationStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}
class NotificationSelector<T> extends BlocSelector<NotificationBloc, NotificationState, T>{
  NotificationSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
    builder: (_, data) => builder(data),
  );
}

class NotificationStatusListener extends BlocListener<NotificationBloc, NotificationState> {
  NotificationStatusListener({
    required Iterable<NotificationStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
