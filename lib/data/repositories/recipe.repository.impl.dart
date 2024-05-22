import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pair/src/pair_base.dart';
import 'package:uq_system_app/core/bases/responses/paginate_response.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/domain/entities/comment.dart';
import 'package:uq_system_app/domain/entities/enum/enum_mapper.dart';
import 'package:uq_system_app/domain/entities/params/paginate_comment_params.dart';
import 'package:uq_system_app/domain/entities/params/paginate_recipe.params.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';
import 'package:uq_system_app/domain/repositories/recipe.repository.dart';

import '../models/instruction/instruction.request.dart';
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
    List<MultipartFile> instructionImages = [];
    for (int i = 0; i < recipeDetailsRequest.instructions.length; i++) {
      if (recipeDetailsRequest.instructions[i].images != null &&
          recipeDetailsRequest.instructions[i].images!.isNotEmpty) {
        for(File image in recipeDetailsRequest.instructions[i].images!){
          instructionImages.add(MultipartFile.fromFileSync(image.path ,filename: 'instructionImages[$i]'));
        }
      }
    }

    Map<String, dynamic> ingredientsData = {
      "ingredients": recipeDetailsRequest.ingredients,
    };

    String ingredientsString = jsonEncode(ingredientsData);
    var instructionsData = recipeDetailsRequest.instructions.map((e) => {
      "title": e.title,
      "content": e.content,
      "order" : e.order,
      "startAt" : e.startAt,
      "endAt" : e.endAt,
    }).toList() ;
    String instructionsString = jsonEncode({
      "instructions": instructionsData,
    });
    var result = await _networkDataSource.createRecipe(
      title : recipeDetailsRequest.title ?? "",
      content : recipeDetailsRequest.content,
      cookTime : recipeDetailsRequest.cookTime,
      servers : recipeDetailsRequest.servers,
      image : recipeDetailsRequest.image ?? File(""),
      video : recipeDetailsRequest.video,
      ingredients: ingredientsString,
      instructions : instructionsString,
      instructionImages: instructionImages,
      status: const RecipeStatusConverter().toJson(recipeDetailsRequest.status)
    );
    return result.data.mapToEntity();
  }

  @override
  Future<List<Recipe>> getSuggestRecipes(String title) async{
    var result = await _networkDataSource.getSuggestRecipes(title);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

}
