import 'package:uq_system_app/data/repositories/system/system.repository.dart';
import 'package:uq_system_app/data/repositories/system/system.repository.impl.dart';
import 'package:uq_system_app/data/repositories/user/user.repository.dart';
import 'package:uq_system_app/data/repositories/user/user.repository.impl.dart';
import 'package:uq_system_app/data/sources/local/local.dart';
import 'package:uq_system_app/di/injector.dart';
import 'dart:async';

FutureOr<void> registerRepositories() {
  provider.registerSingleton<SystemRepository>(
    SystemRepositoryImpl(
      provider.get<LocalDataSource>(),
    ),
  );
  provider.registerSingleton<UserRepository>(
    UserRepositoryImpl(),
  );
}
