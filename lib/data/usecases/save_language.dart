import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/repositories/system/system.repository.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:flutter/material.dart';

@lazySingleton
class SaveLanguage extends UseCase<void, Locale> {
  final SystemRepository _systemRepository;

  const SaveLanguage(this._systemRepository);

  @override
  Future<void> call(Locale params) async {
    await _systemRepository.saveLanguage(params);
  }
}
