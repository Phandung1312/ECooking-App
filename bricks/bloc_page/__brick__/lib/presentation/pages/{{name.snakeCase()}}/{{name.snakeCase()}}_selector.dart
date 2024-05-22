import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_bloc.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Selector<T>
    extends BlocSelector<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State, T> {
  {{name.pascalCase()}}Selector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class {{name.pascalCase()}}Builder<T>
extends BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State> {
{{name.pascalCase()}}Builder({
required Iterable<{{name.pascalCase()}}Status> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class {{name.pascalCase()}}StatusListener extends BlocListener<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}StatusListener({
    required Iterable<{{name.pascalCase()}}Status> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
