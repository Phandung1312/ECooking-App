import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_bloc.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_state.dart';

class NotificationSettingsSelector<T>
    extends BlocSelector<NotificationSettingsBloc, NotificationSettingsState, T> {
  NotificationSettingsSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class NotificationSettingsBuilder<T>
extends BlocBuilder<NotificationSettingsBloc, NotificationSettingsState> {
NotificationSettingsBuilder({
required Iterable<NotificationSettingsStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class NotificationSettingsStatusListener extends BlocListener<NotificationSettingsBloc, NotificationSettingsState> {
  NotificationSettingsStatusListener({
    required Iterable<NotificationSettingsStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
