import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_event.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}ErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    {{name.pascalCase()}}ErrorOccurred event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) {
    emit(state.copyWith(
      status: {{name.pascalCase()}}Status.failure,
    ));
  }
}
