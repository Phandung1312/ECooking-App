import 'package:uq_system_app/presentation/blocs/system/system_bloc.dart';
import 'package:uq_system_app/presentation/blocs/system/system_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemLanguageListener extends BlocListener<SystemBloc, SystemState> {
  SystemLanguageListener({
    super.key,
    required void Function(Locale locale) listener,
    required Widget child,
  }) : super(
          listenWhen: (previousState, state) =>
              previousState.locale != state.locale,
          listener: (_, state) => listener(state.locale),
          child: child,
        );
}

class SystemLanguageSelector
    extends BlocSelector<SystemBloc, SystemState, Locale> {
  SystemLanguageSelector({
    super.key,
    required Widget Function(Locale locale) builder,
  }) : super(
          selector: (state) => state.locale,
          builder: (_, status) => builder(status),
        );
}
