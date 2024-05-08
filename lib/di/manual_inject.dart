

import 'dart:async';

import '../core/languages/languages.dart';
import '../data/sources/local/local.dart';
import '../data/usecases/save_language.dart';
import '../presentation/blocs/system/system_bloc.dart';
import 'injector.dart';

FutureOr<void> manualRegister() async {
  getIt.registerSingleton<SystemBloc>(
    SystemBloc(
      getIt.get<SaveLanguage>(),
      locale: await getIt
          .get<LocalDataSource>() //
          .getLanguage()
          .then(AppLanguages.parseLanguage)
          .then((value) => value.locale),
    ),
  );
}