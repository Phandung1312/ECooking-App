

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/domain/repositories/recipe.repository.dart';

import '../../../core/bases/usecases/base_use_case.dart';

@injectable
class GetRecipesUseCase extends UseCase<List<Recipe>, PaginateRecipeParams>{
  final RecipeRepository _recipeRepository;
  GetRecipesUseCase(this._recipeRepository);
  @override
  Future<List<Recipe>> call(PaginateRecipeParams params) {
    return _recipeRepository.getRecipes(params);
  }


}

