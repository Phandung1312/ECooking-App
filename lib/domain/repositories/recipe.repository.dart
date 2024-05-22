

import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';

abstract class RecipeRepository{
  Future<List<Recipe>> getRecipes(PaginateRecipeParams recipeParams);
  Future<RecipeDetails> getRecipeDetails(int id);
  //Wrongs dependency
  Future<RecipeDetails> createRecipe(RecipeDetailsRequest recipeDetailsRequest);
  Future<List<Recipe>> getSuggestRecipes(String title);
}