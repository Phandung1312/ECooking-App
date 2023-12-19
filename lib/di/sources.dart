import 'package:uq_system_app/data/sources/local/local.dart';
import 'package:uq_system_app/data/services/api/api.service.dart';
import 'package:uq_system_app/data/sources/network/network.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

FutureOr<void> registerDataSources() async {
  final localDataSource = LocalDataSource(
    provider.get<SharedPreferences>(),
  );

  provider.registerSingleton<LocalDataSource>(
    localDataSource,
  );

  provider.registerSingleton<NetworkDataSource>(
    NetworkDataSource(
      provider.get<ApiServices>(),
    ),
  );
}
