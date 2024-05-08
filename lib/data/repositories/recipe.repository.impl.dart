

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/domain/repositories/recipe.repository.dart';

import '../sources/network/network.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl extends RecipeRepository{
  final NetworkDataSource _networkDataSource;
  RecipeRepositoryImpl(this._networkDataSource);
  @override
  Future<List<Recipe>> getRecipes(PaginateRecipeParams recipeParams) async {
    var result = await _networkDataSource.getRecipes(recipeParams.page, recipeParams.perPage, recipeParams.recipeSearchType);
    return result.data.map((e) => e.mapToEntity()).toList();
  }
}
