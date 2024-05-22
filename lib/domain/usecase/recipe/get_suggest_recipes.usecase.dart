

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/recipe.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class GetSuggestRecipesUseCase extends UseCase<List<Recipe>, String> {
  final RecipeRepository _recipeRepository;

  GetSuggestRecipesUseCase(this._recipeRepository);

  @override
  Future<List<Recipe>> call(String params) {
   return _recipeRepository.getSuggestRecipes(params);
  }


}