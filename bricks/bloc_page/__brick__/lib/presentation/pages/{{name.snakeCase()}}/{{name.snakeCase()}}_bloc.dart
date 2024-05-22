import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_event.dart';
import 'package:uq_system_app/presentation/pages/{{name.snakeCase()}}/{{name.snakeCase()}}_state.dart';
import '../../../core/exceptions/exception.dart';
@injectable
class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}ErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add({{name.pascalCase()}}ErrorOccurred(BaseException.from(error)));
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
