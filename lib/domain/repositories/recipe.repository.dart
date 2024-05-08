

import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

abstract class RecipeRepository{
  Future<List<Recipe>> getRecipes(PaginateRecipeParams recipeParams);
}