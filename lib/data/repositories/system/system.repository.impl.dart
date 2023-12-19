import 'dart:ui';

import 'package:uq_system_app/data/repositories/system/system.repository.dart';
import 'package:uq_system_app/data/sources/local/local.dart';

class SystemRepositoryImpl extends SystemRepository {
  final LocalDataSource localDataSource;

  SystemRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveLanguage(Locale locale) async {
    await localDataSource.saveLanguage(locale.countryCode);
  }
}
