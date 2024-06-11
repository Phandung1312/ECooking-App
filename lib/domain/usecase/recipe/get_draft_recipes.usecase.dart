

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/recipe.dart';
import '../../repositories/recipe.repository.dart';

@injectable
class GetDraftRecipesUseCase extends UseCase<List<Recipe>, CommonPaginateParams>{
  final RecipeRepository _recipeRepository;

  GetDraftRecipesUseCase(this._recipeRepository);

  @override
  Future<List<Recipe>> call(CommonPaginateParams params) {
    return _recipeRepository.getDraftRecipes(params);
  }


}