import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

part 'create_recipe_event.freezed.dart';

@freezed
class CreateRecipeEvent with _$CreateRecipeEvent {
  const factory CreateRecipeEvent.errorOccurred([BaseException? error]) = CreateRecipeErrorOccurred;
  const factory CreateRecipeEvent.update(RecipeDetailsRequest recipeDetailsRequest) = CreateRecipeUpdate;
  const factory CreateRecipeEvent.addIngredient() = CreateRecipeAddIngredient;
  const factory CreateRecipeEvent.updateIngredient({required String content, required int index}) = CreateRecipeUpdateIngredients;
  const factory CreateRecipeEvent.removeIngredient({required int index}) = CreateRecipeRemoveIngredients;
  const factory CreateRecipeEvent.addInstruction() = CreateRecipeAddInstruction;
  const factory CreateRecipeEvent.updateInstruction({required InstructionRequest instruction, required int index}) = CreateRecipeUpdateInstructions;
  const factory CreateRecipeEvent.removeInstruction({required int index}) = CreateRecipeRemoveInstructions;
  const factory CreateRecipeEvent.create(RecipeStatus status) = CreateRecipeCreate;
}
