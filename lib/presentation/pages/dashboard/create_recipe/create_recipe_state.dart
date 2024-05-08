import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'create_recipe_state.freezed.dart';

enum CreateRecipeStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class CreateRecipeState with _$CreateRecipeState {
  const factory CreateRecipeState({
    @Default(CreateRecipeStatus.initial) CreateRecipeStatus status,
    BaseException? error,
  }) = _CreateRecipeState;
}
