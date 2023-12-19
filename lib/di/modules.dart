import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.dart';

FutureOr<void> registerModules() async {
  provider.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  provider.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );
}
