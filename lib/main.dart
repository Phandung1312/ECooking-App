import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:uq_system_app/presentation/blocs/bloc_observer.dart';
import 'package:uq_system_app/presentation/blocs/system/system_bloc.dart';
import 'package:uq_system_app/presentation/blocs/system/system_state.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import 'env.dart';
import 'core/languages/languages.dart';
import 'di/injector.dart';
import 'presentation/blocs/global_bloc_providers.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await injectDependencies();

  Bloc.observer = const AppBlocObserver();

  runApp(
    GlobalBlocProviders(
      child: AppLanguages(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.account != current.account && current.account == null,
          listener: (context, state) {
            // _appRouter.replaceAll([const LoginRoute()]);
            _appRouter.replaceAll([const DashboardRoute()]);
          },
        ),
      ],
      child: BlocBuilder<SystemBloc, SystemState>(builder: (context, system) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: system.theme.themeData.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppEnv.appName,
            theme: system.theme.themeData.copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              }),
            ),
            locale: system.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: [
              ...context.localizationDelegates,
              // more delegates here
            ],
            routerConfig: _appRouter.config(
              navigatorObservers: () => [AutoRouteObserver()],
            ),
          ),
        );
      }),
    );
  }
}
