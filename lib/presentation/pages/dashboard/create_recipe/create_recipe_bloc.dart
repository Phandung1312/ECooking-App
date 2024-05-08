import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'create_recipe_event.dart';
import 'create_recipe_state.dart';

@injectable
class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  CreateRecipeBloc() : super(const CreateRecipeState()) {
    on<CreateRecipeErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    CreateRecipeErrorOccurred event,
    Emitter<CreateRecipeState> emit,
  ) {
    emit(state.copyWith(
      status: CreateRecipeStatus.failure,
    ));
  }
}
