

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../../data/models/recipe_details/recipe_details.request.dart';
import '../../entities/recipe_details.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class CreateRecipeUseCase extends UseCase<RecipeDetails, RecipeDetailsRequest> {
  final RecipeRepository _recipeRepository;

  CreateRecipeUseCase(this._recipeRepository);

  @override
  Future<RecipeDetails> call(RecipeDetailsRequest params) {
    return _recipeRepository.createRecipe(params);
  }



}