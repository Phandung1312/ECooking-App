import 'dart:async';



import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/di/injector.config.dart';

import 'manual_inject.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection(String env) async {
  await getIt.init(environment: env);
  await manualRegister();
}
