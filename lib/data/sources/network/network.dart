import 'dart:io';

import 'package:uq_system_app/core/bases/responses/base_response.dart';
import 'package:uq_system_app/core/bases/responses/paginate_response.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/data/models/login/google_login_params.dart';
import 'package:uq_system_app/data/models/member/member.model.dart';
import 'package:uq_system_app/data/models/member_details/member_details.model.dart';
import 'package:uq_system_app/data/models/notification/notification.model.dart';
import 'package:uq_system_app/data/models/recipe/recipe.model.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.request.dart';
import 'package:uq_system_app/data/models/recipe_details/recipe_details.response.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/data/models/search/search_result.model.dart';
import 'package:uq_system_app/data/services/api/api.service.dart';
import 'package:uq_system_app/data/sources/network/network_urls.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/params/follow.params.dart';
import '../../models/comment/comment.response.dart';
import '../../models/report/report.request.dart';

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

  @GET('${NetworkUrls.recipe}/{id}/suggest')
  Future<BaseResponse<List<RecipeModel>>> getSuggestRecipes(
      @Path('id') int id,
      @Query('title') String title);

  @POST(NetworkUrls.recipe)
  Future<BaseResponse<RecipeDetailsResponse>> createRecipe({
    @Body() required RecipeDetailsRequest recipeDetailsRequest,
  });

  @PUT('${NetworkUrls.recipe}/{id}')
  Future<BaseResponse<RecipeDetailsResponse>> updateRecipe(
      @Path('id') int id, @Body() RecipeDetailsRequest recipeDetailsRequest);

  @PUT(NetworkUrls.recipeFavorite)
  Future<BaseResponse> changeRecipeFavorite(
      @Body() RecipeFeatureRequest request);

  @PUT(NetworkUrls.savedRecipe)
  Future<BaseResponse> updateSavedRecipe(@Body() RecipeFeatureRequest request);
  @DELETE('${NetworkUrls.recipe}/{id}')
  Future<BaseResponse> deleteRecipe(@Path('id') int id);
  //Comment
  @GET('${NetworkUrls.recipe}/{id}/comments')
  Future<PaginateResponse<List<CommentResponse>>> getComments(
      @Path('id') int id,
      @Query('page') int page,
      @Query('perPage') int perPage);

  @POST(NetworkUrls.comment)
  Future<BaseResponse<CommentResponse>> createComment(@Body() commentRequest);

  //User
  @GET(NetworkUrls.topMember)
  Future<PaginateResponse<List<MemberModel>>> getTopMembers(
      @Query('page') int page, @Query('perPage') int perPage);
  @PUT('${NetworkUrls.user}/{id}')
  Future<BaseResponse<MemberDetailsModel>> updateUser(
      @Path('id') int id, @Body() AccountRequest accountRequest);
  @GET('${NetworkUrls.user}/{id}')
  Future<BaseResponse<MemberDetailsModel>> getUser(@Path('id') int id);

  @GET('${NetworkUrls.user}/{id}/recipes')
  Future<PaginateResponse<List<RecipeModel>>> getUserRecipes(@Path('id') int id,
      @Query('page') int page, @Query('perPage') int perPage);

  @GET('${NetworkUrls.user}/saved-recipes')
  Future<PaginateResponse<List<RecipeModel>>> getSavedRecipes(
      @Query('page') int page,
      @Query('perPage') int perPage);

  @GET('${NetworkUrls.user}/draft-recipes')
  Future<PaginateResponse<List<RecipeModel>>> getDraftRecipes(
      @Query('page') int page,
      @Query('perPage') int perPage);

  @GET('${NetworkUrls.user}/{id}/followers')
  Future<PaginateResponse<List<MemberModel>>> getFollowers(@Path('id') int id,
      @Query('page') int page, @Query('perPage') int perPage);
  @GET('${NetworkUrls.user}/{id}/followings')
  Future<PaginateResponse<List<MemberModel>>> getFollowings(@Path('id') int id,
      @Query('page') int page, @Query('perPage') int perPage);

  @PUT('${NetworkUrls.user}/follows')
  Future<BaseResponse> updateFollow(@Body() FollowParams followParams);
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

  //Upload
  @POST(NetworkUrls.uploadImage)
  @MultiPart()
  Future<BaseResponse<String>> uploadImage(@Part() File image);

  @POST(NetworkUrls.uploadVideo)
  @MultiPart()
  Future<BaseResponse<String>> uploadVideo(@Part() File video);

  //Notification
  @GET(NetworkUrls.notification)
  Future<PaginateResponse<List<NotificationModel>>> getNotifications(
      @Query('page') int page, @Query('perPage') int perPage);

  @GET('${NetworkUrls.notification}/{id}')
  Future<BaseResponse<NotificationModel>> getNotification(@Path('id') int id);

  @GET('${NetworkUrls.notification}/count-unread')
  Future<BaseResponse<int>> countUnreadNotification();

  @PUT('${NetworkUrls.notification}/{id}/read')
  Future<HttpResponse> markAsRead(@Path('id') int id);


  @POST(NetworkUrls.report)
  Future<BaseResponse> createReport(@Body() ReportRequest reportRequest);
}
