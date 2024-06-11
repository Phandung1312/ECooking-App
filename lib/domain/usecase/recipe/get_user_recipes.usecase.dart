

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

import '../../repositories/recipe.repository.dart';

@injectable
class GetUserRecipesUseCase extends UseCase<List<Recipe>, CommonPaginateParams>{
  final RecipeRepository _recipeRepository;
  const GetUserRecipesUseCase(this._recipeRepository);
  @override
  Future<List<Recipe>> call(CommonPaginateParams params) {
    return _recipeRepository.getUserRecipes(params);
  }

}