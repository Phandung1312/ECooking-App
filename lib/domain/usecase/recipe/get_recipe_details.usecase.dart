

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';

import '../../repositories/recipe.repository.dart';
@injectable
class GetRecipeDetailsDetailsUseCase extends UseCase<RecipeDetails, int>{
  final RecipeRepository repository;
  GetRecipeDetailsDetailsUseCase(this.repository);
  @override
  Future<RecipeDetails> call(int params) {
    return repository.getRecipeDetails(params);
  }

}