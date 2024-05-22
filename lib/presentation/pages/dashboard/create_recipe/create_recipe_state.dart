import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';

part 'create_recipe_state.freezed.dart';

enum CreateRecipeStatus {
  initial,
  loading,
  updated,
  success,
  failure,
}

@freezed
class CreateRecipeState with _$CreateRecipeState {
  const factory CreateRecipeState({
    @Default(1) int currentOrderInstruction,
    @Default(RecipeDetailsRequest()) RecipeDetailsRequest recipeDetailsRequest,
    @Default(false) bool isDataValid,
    @Default(<InstructionRequest>[]) List<InstructionRequest> instructions,
    @Default(RecipeDetails()) RecipeDetails createdRecipe,
    @Default(CreateRecipeStatus.initial) CreateRecipeStatus status,
    BaseException? error,
  }) = _CreateRecipeState;
}
