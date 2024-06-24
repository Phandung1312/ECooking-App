import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

import '../../../domain/entities/recipe.dart';

part 'saved_recipes_state.freezed.dart';

enum SavedRecipesStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SavedRecipesState with _$SavedRecipesState {
  const factory SavedRecipesState({
    @Default([]) List<Recipe> draftRecipes,
    @Default(SavedRecipesStatus.initial) SavedRecipesStatus status,
    BaseException? error,
  }) = _SavedRecipesState;
}
