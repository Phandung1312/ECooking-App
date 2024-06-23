

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/suggest_recipe.params.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/recipe.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class GetSuggestRecipesUseCase extends UseCase<List<Recipe>, SuggestRecipeParams> {
  final RecipeRepository _recipeRepository;

  GetSuggestRecipesUseCase(this._recipeRepository);

  @override
  Future<List<Recipe>> call(SuggestRecipeParams params) {
   return _recipeRepository.getSuggestRecipes(params);
  }


}