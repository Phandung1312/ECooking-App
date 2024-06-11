

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';

import '../../../domain/entities/comment.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe.dart';

part 'recipe_details_state.freezed.dart';

enum RecipeDetailsStatus {
  initial,
  loading,
  loadingComments,
  loadedComments,
  loadingSuggests,
  loadedSuggests,
  updating,
  updated,
  success,
  failure,
}

@freezed
class RecipeDetailsState with _$RecipeDetailsState {
  const factory RecipeDetailsState({
    @Default(RecipeDetails()) RecipeDetails recipeDetails,
    @Default(<Comment>[]) List<Comment> comments,
    @Default(0) int totalComments,
    @Default(<Recipe>[]) List<Recipe> suggests,
    @Default(RecipeDetailsStatus.initial) RecipeDetailsStatus status,
    BaseException? error,
  }) = _RecipeDetailsState;
}
