import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';

import '../../../../domain/entities/enum/enum.dart';
import '../../../../domain/usecase/recipe/create_recipe.usecase.dart';
import 'create_recipe_event.dart';
import 'create_recipe_state.dart';

@injectable
class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  CreateRecipeUseCase createRecipeUseCase;

  CreateRecipeBloc(this.createRecipeUseCase)
      : super(const CreateRecipeState()) {
    on<CreateRecipeErrorOccurred>(_onErrorOccurred);
    on<CreateRecipeUpdate>(_onUpdate);
    on<CreateRecipeAddIngredient>(_onAddIngredient);
    on<CreateRecipeUpdateIngredients>(_onUpdateIngredients);
    on<CreateRecipeRemoveIngredients>(_onRemoveIngredients);
    on<CreateRecipeAddInstruction>(_onAddInstruction);
    on<CreateRecipeUpdateInstructions>(_onUpdateInstructions);
    on<CreateRecipeRemoveInstructions>(_onRemoveInstructions);
    on<CreateRecipeCreate>(_onCreate);
  }

  FutureOr<void> _onCreate(
    CreateRecipeCreate event,
    Emitter<CreateRecipeState> emit,
  ) async {
    EasyLoading.show();
    var result = await createRecipeUseCase(state.recipeDetailsRequest.copyWith(
      status: event.status,
    ));
    EasyLoading.dismiss();
    emit(state.copyWith(
        status: CreateRecipeStatus.success, createdRecipe: result));
  }

  FutureOr<void> _onUpdate(
    CreateRecipeUpdate event,
    Emitter<CreateRecipeState> emit,
  ) {
    emit(state.copyWith(
      recipeDetailsRequest: event.recipeDetailsRequest,
      status: CreateRecipeStatus.updated,
      isDataValid: _validateData(event.recipeDetailsRequest),
    ));
  }

  FutureOr<void> _onAddInstruction(
    CreateRecipeAddInstruction event,
    Emitter<CreateRecipeState> emit,
  ) {
    emit(state.copyWith(
      recipeDetailsRequest: state.recipeDetailsRequest.copyWith(
        instructions: [
          ...state.recipeDetailsRequest.instructions,
          InstructionRequest(order: state.currentOrderInstruction)
        ],
      ),
      status: CreateRecipeStatus.updated,
      currentOrderInstruction: state.currentOrderInstruction + 1,
    ));
  }

  FutureOr<void> _onUpdateInstructions(
    CreateRecipeUpdateInstructions event,
    Emitter<CreateRecipeState> emit,
  ) {
    emit(state.copyWith(
      status: CreateRecipeStatus.loading,
    ));
    var newInstructions =
        List<InstructionRequest>.from(state.recipeDetailsRequest.instructions);
    newInstructions[event.index] = event.instruction;
    var newRecipe = state.recipeDetailsRequest.copyWith(
      instructions: newInstructions,
    );
    emit(state.copyWith(
      recipeDetailsRequest: newRecipe,
      status: CreateRecipeStatus.updated,
      isDataValid: _validateData(newRecipe),
    ));
  }

  FutureOr<void> _onRemoveInstructions(
    CreateRecipeRemoveInstructions event,
    Emitter<CreateRecipeState> emit,
  ) {
    var newInstructions =
        List<InstructionRequest>.from(state.recipeDetailsRequest.instructions);
    newInstructions.removeAt(event.index);
    var newRecipe = state.recipeDetailsRequest.copyWith(
      instructions: newInstructions,
    );
    emit(state.copyWith(
      recipeDetailsRequest: newRecipe,
      status: CreateRecipeStatus.updated,
      isDataValid: _validateData(newRecipe),
    ));
  }

  FutureOr<void> _onAddIngredient(
    CreateRecipeAddIngredient event,
    Emitter<CreateRecipeState> emit,
  ) {
    emit(state.copyWith(
      recipeDetailsRequest: state.recipeDetailsRequest.copyWith(
        ingredients: [...state.recipeDetailsRequest.ingredients, ''],
      ),
      status: CreateRecipeStatus.updated,

    ));
  }

  FutureOr<void> _onUpdateIngredients(
    CreateRecipeUpdateIngredients event,
    Emitter<CreateRecipeState> emit,
  ) {
    var newIngredients =
        List<String>.from(state.recipeDetailsRequest.ingredients);
    if (event.index >= newIngredients.length) {
      newIngredients.add(event.content);
    } else {
      newIngredients[event.index] = event.content;
    }
    var newRecipe = state.recipeDetailsRequest.copyWith(
      ingredients: newIngredients,
    );
    emit(state.copyWith(
      recipeDetailsRequest: newRecipe,
      status: CreateRecipeStatus.updated,
      isDataValid: _validateData(newRecipe),
    ));
  }

  FutureOr<void> _onRemoveIngredients(
    CreateRecipeRemoveIngredients event,
    Emitter<CreateRecipeState> emit,
  ) {
    var newIngredients =
        List<String>.from(state.recipeDetailsRequest.ingredients);
    newIngredients.removeAt(event.index);
    var newRecipe = state.recipeDetailsRequest.copyWith(
      ingredients: newIngredients,
    );
    emit(state.copyWith(
      recipeDetailsRequest: newRecipe,
      status: CreateRecipeStatus.updated,
      isDataValid: _validateData(newRecipe),
    ));
  }

  bool _validateData(RecipeDetailsRequest data) {
    if (data.title == null ||
        data.title!.isEmpty) {
      return false;
    }
    if (data.image == null) {
      return false;
    }
    if (data.ingredients.isEmpty) {
      return false;
    }
    if (data.ingredients
        .every((ingredient) => ingredient.isEmpty)) {
      return false;
    }
    if (data.instructions.isEmpty) {
      return false;
    }
    if (data.instructions.every((instruction) =>
        instruction.content == null || instruction.content!.isEmpty)) {
      return false;
    }
    return true;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    add(const CreateRecipeErrorOccurred());
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
