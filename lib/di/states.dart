import 'package:uq_system_app/core/languages/languages.dart';
import 'package:uq_system_app/data/sources/local/local.dart';
import 'package:uq_system_app/data/usecases/logout.dart';
import 'package:uq_system_app/data/usecases/save_language.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/system/system_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_bloc.dart';
import 'dart:async';

import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart';

FutureOr<void> registerStates() async {
  provider.registerSingleton<AuthBloc>(
    AuthBloc(
      provider.get<Logout>(),
    ),
  );

  provider.registerSingleton<SystemBloc>(
    SystemBloc(
      provider.get<SaveLanguage>(),
      locale: await provider
          .get<LocalDataSource>() //
          .getLanguage()
          .then(AppLanguages.parseLanguage)
          .then((value) => value.locale),
    ),
  );

  provider.registerSingleton<AccountBloc>(
    AccountBloc(),
  );

  provider.registerSingleton<HomeBloc>(
    HomeBloc(),
  );
}
