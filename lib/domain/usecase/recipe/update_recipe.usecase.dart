

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';
import 'package:uq_system_app/domain/repositories/recipe.repository.dart';

@injectable
class UpdateRecipeUseCase extends UseCase<RecipeDetails, RecipeDetailsRequest>{
  final RecipeRepository _recipeRepository;
  const UpdateRecipeUseCase(this._recipeRepository);
  @override
  Future<RecipeDetails> call(RecipeDetailsRequest params) {
    return _recipeRepository.updateRecipe(params);
  }

}