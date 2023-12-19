import 'package:uq_system_app/core/bases/responses/base_response.dart';
import 'package:uq_system_app/data/models/request/login_params.dart';
import 'package:uq_system_app/data/models/response/account.dart';
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

  @POST(NetworkUrls.login)
  Future<BaseResponse<Account>> login(
    @Body() LoginParams params,
  );

  @POST(NetworkUrls.logout)
  Future<void> logout();
}
