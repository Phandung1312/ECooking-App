import 'dart:io';

import 'package:uq_system_app/core/bases/responses/base_response.dart';
import 'package:uq_system_app/core/bases/responses/paginate_response.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/data/models/login/google_login_params.dart';
import 'package:uq_system_app/data/models/member/member.model.dart';
import 'package:uq_system_app/data/models/recipe/recipe.model.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.response.dart';
import 'package:uq_system_app/data/models/search/search_result.model.dart';
import 'package:uq_system_app/data/services/api/api.service.dart';
import 'package:uq_system_app/data/sources/network/network_urls.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/comment/comment.response.dart';

part 'network.g.dart';

@RestApi()
abstract class NetworkDataSource {
  factory NetworkDataSource(
    ApiServices apiServices, {
    String baseUrl,
  }) = _NetworkDataSource;

  @POST(NetworkUrls.googleLogin)
  Future<BaseResponse<AccountResponse>> googleLogin(
      @Body() GoogleLoginParams googleLoginParams);

  @POST(NetworkUrls.refresh)
  Future<BaseResponse> refreshToken(
    @Query('refreshToken') String refreshToken,
  );

  //Recipe

  @GET(NetworkUrls.recipe)
  Future<PaginateResponse<List<RecipeModel>>> getRecipes(
      @Query('page') int page,
      @Query('perPage') int perPage,
      @Query('type') String recipeSearchType);

  @GET('${NetworkUrls.recipe}/{id}')
  Future<BaseResponse<RecipeDetailsResponse>> getRecipeDetails(
      @Path('id') int id);

  @GET(NetworkUrls.suggestRecipe)
  Future<BaseResponse<List<RecipeModel>>> getSuggestRecipes(
      @Query('title') String title);

  @POST(NetworkUrls.recipe)
  @MultiPart()
  Future<BaseResponse<RecipeDetailsResponse>> createRecipe({
    @Part(name: 'video') File? video,
    @Part(name: 'title') required String title,
    @Part(name: 'content') String? content,
    @Part(name: 'cookTime') String? cookTime,
    @Part(name: 'servers') String? servers,
    @Part(name: "image") required File image,
    @Part(name: 'ingredients') required String ingredients,
    @Part(name: 'instructions') required String instructions,
    @Part() required List<MultipartFile> instructionImages,
    @Part(name: "status") required int status,
  });

  //Comment
  @GET('${NetworkUrls.recipe}/{id}/comments')
  Future<PaginateResponse<List<CommentResponse>>> getComments(
      @Path('id') int id,
      @Query('page') int page,
      @Query('perPage') int perPage);

  //User
  @GET(NetworkUrls.topMember)
  Future<PaginateResponse<List<MemberModel>>> getTopMembers(
      @Query('page') int page, @Query('perPage') int perPage);

  //Search
  @GET(NetworkUrls.search)
  Future<BaseResponse<SearchResultModel>> search(
      {@Query('text') required String title,
      @Query('page') required int page,
      @Query('perPage') required int perPage,
      @Query('searchType') required String searchType});

  @GET(NetworkUrls.suggestSearch)
  Future<BaseResponse<List<String>>> getSuggestSearch(
      @Query('keyword') String keyword);
}
