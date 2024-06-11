

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class ChangeRecipeFavorite extends UseCase<void, RecipeFeatureRequest>{
  final RecipeRepository _recipeRepository;
  const ChangeRecipeFavorite(this._recipeRepository);
  @override
  Future<void> call(RecipeFeatureRequest params) {
    return _recipeRepository.changeFavoriteStatus(params);
  }

}