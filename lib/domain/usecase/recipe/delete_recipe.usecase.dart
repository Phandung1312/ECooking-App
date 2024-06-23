

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class DeleteRecipeUseCase extends UseCase<void, int>{
  final RecipeRepository _recipeRepository;
  const DeleteRecipeUseCase(this._recipeRepository);
  @override
  Future<void> call(int params) {
    return _recipeRepository.deleteRecipe(params);
  }

}