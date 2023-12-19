import 'package:flutter_config/flutter_config.dart';

class AppEnv {
  static AppEnvName get name => AppEnvName.parse(_get('APP_ENV'));

  static String _get(String key) => FlutterConfig.get(key);

  static String get baseUrl => _get('BASE_URL');

  static String get appName => _get('APP_NAME');
}

enum AppEnvName {
  dev,
  staging,
  production;

  static AppEnvName parse(String value) => values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
        orElse: () => dev,
      );
}
