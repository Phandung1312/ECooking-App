
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/params/suggest_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';
import 'package:uq_system_app/domain/repositories/recipe.repository.dart';

import '../sources/network/network.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl extends RecipeRepository {
  final NetworkDataSource _networkDataSource;

  RecipeRepositoryImpl(this._networkDataSource);

  @override
  Future<List<Recipe>> getRecipes(PaginateRecipeParams recipeParams) async {
    var result = await _networkDataSource.getRecipes(
        recipeParams.page, recipeParams.perPage, recipeParams.recipeSearchType);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<RecipeDetails> getRecipeDetails(int id) async {
    var result = await _networkDataSource.getRecipeDetails(id);
    return result.data.mapToEntity();
  }

  @override
  Future<RecipeDetails> createRecipe(
      RecipeDetailsRequest recipeDetailsRequest) async{
    var result = await _networkDataSource.createRecipe(
      recipeDetailsRequest: recipeDetailsRequest,
    );
    return result.data.mapToEntity();
  }

  @override
  Future<List<Recipe>> getSuggestRecipes(SuggestRecipeParams suggestRecipeParams) async{
    var result = await _networkDataSource.getSuggestRecipes(suggestRecipeParams.id, suggestRecipeParams.title);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<List<Recipe>> getUserRecipes(CommonPaginateParams params) async{
    var result  = await _networkDataSource.getUserRecipes(params.id, params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<void> changeFavoriteStatus(RecipeFeatureRequest recipeFeatureRequest) async{
    await _networkDataSource.changeRecipeFavorite(recipeFeatureRequest);
  }

  @override
  Future<void> changeSavedStatus(RecipeFeatureRequest recipeFeatureRequest) async{
    await _networkDataSource.updateSavedRecipe(recipeFeatureRequest);
  }

  @override
  Future<List<Recipe>> getSavedRecipes(CommonPaginateParams params)async {
    var result  = await _networkDataSource.getSavedRecipes(params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<RecipeDetails> updateRecipe(RecipeDetailsRequest recipeDetailsRequest) async{
    var result = await _networkDataSource.updateRecipe(recipeDetailsRequest.id ?? 0, recipeDetailsRequest);
    return result.data.mapToEntity();
  }

  @override
  Future<List<Recipe>> getDraftRecipes(CommonPaginateParams params) async{
    var result  = await _networkDataSource.getDraftRecipes(params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<void> deleteRecipe(int id) async{
    await _networkDataSource.deleteRecipe(id);
  }

}
