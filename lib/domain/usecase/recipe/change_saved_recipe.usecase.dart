import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../../data/models/recipe_feature/recipe_feature.request.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class ChangeSavedRecipeUseCase extends UseCase<void, RecipeFeatureRequest> {
  final RecipeRepository _recipeRepository;

  ChangeSavedRecipeUseCase(this._recipeRepository);

  @override
  Future<void> call(RecipeFeatureRequest params) {
    return _recipeRepository.changeSavedStatus(params);
  }
}
