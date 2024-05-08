import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uq_system_app/data/services/api/api.service.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:uq_system_app/data/sources/network/network.dart';
import 'package:uq_system_app/env.dart';

import 'injector.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
  @lazySingleton
  FlutterSecureStorage get getFlutterSecureStorage =>
      const FlutterSecureStorage();

  @lazySingleton
  ApiServices registerApiService() => ApiServices(
        baseUrl: AppEnv.baseUrl,
        authRepository: getIt.get<AuthServices>(),
      );
  @lazySingleton
  NetworkDataSource registerNetworkDataSource(ApiServices apiServices) => NetworkDataSource(apiServices);
  @Named('key')
  @lazySingleton
  String registerKey() => 'default';
}
