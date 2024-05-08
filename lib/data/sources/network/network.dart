import 'package:uq_system_app/core/bases/responses/base_response.dart';
import 'package:uq_system_app/core/bases/responses/paginate_response.dart';
import 'package:uq_system_app/data/models/login/google_login_params.dart';
import 'package:uq_system_app/data/models/member/member.model.dart';
import 'package:uq_system_app/data/models/recipe/recipe.model.dart';
import 'package:uq_system_app/data/services/api/api.service.dart';
import 'package:uq_system_app/data/sources/network/network_urls.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'network.g.dart';

@RestApi()
abstract class NetworkDataSource {
  factory NetworkDataSource(
    ApiServices apiServices, {
    String baseUrl,
  }) = _NetworkDataSource;

  @POST(NetworkUrls.googleLogin)
  Future<HttpResponse> googleLogin(@Body() GoogleLoginParams googleLoginParams);

  //Recipe

  @GET(NetworkUrls.recipe)
  Future<PaginateResponse<List<RecipeModel>>> getRecipes(
      @Query('page') int page, @Query('perPage') int perPage, @Query('type') String recipeSearchType);

  @GET(NetworkUrls.topMember)
  Future<PaginateResponse<List<MemberModel>>> getTopMembers(
      @Query('page') int page, @Query('perPage') int perPage);
}
