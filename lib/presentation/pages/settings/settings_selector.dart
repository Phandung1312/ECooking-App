import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/settings/settings_bloc.dart';
import 'package:uq_system_app/presentation/pages/settings/settings_state.dart';

class SettingsSelector<T>
    extends BlocSelector<SettingsBloc, SettingsState, T> {
  SettingsSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class SettingsBuilder<T>
extends BlocBuilder<SettingsBloc, SettingsState> {
SettingsBuilder({
required Iterable<SettingsStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class SettingsStatusListener extends BlocListener<SettingsBloc, SettingsState> {
  SettingsStatusListener({
    required Iterable<SettingsStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
