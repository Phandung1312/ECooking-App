import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

part 'view_more_recipes_state.freezed.dart';

enum ViewMoreRecipesStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

@freezed
class ViewMoreRecipesState with _$ViewMoreRecipesState {
  const factory ViewMoreRecipesState({
    @Default(<Recipe>[]) List<Recipe> recipes,
    @Default(0) int recipesPage,
    @Default(ViewMoreRecipesStatus.initial) ViewMoreRecipesStatus status,
    BaseException? error,
  }) = _ViewMoreRecipesState;
}
