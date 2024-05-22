import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletons/skeletons.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
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

  await configureInjection(Environment.dev);
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
    EasyLoading.instance
      ..backgroundColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = context.colors.secondary
      ..textColor = Colors.white
      ..maskColor = context.colors.secondary
      ..userInteractions = false
      ..progressColor = context.colors.secondary;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          // listenWhen: (previous, current) =>
          //     previous.account != current.account && current.account == null,
          listener: (context, state) {
            _appRouter.replaceAll([ const LoginRoute()]);
          },
        ),
      ],
      child: BlocBuilder<SystemBloc, SystemState>(builder: (context, system) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: system.theme.themeData.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: RefreshConfiguration(
            headerBuilder: () => MaterialClassicHeader(
              color: context.colors.secondary,
            ),
            footerBuilder: () => ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              height: 40,
              canLoadingIcon: Container(),
              idleIcon: Container(),
              textStyle: const TextStyle(fontSize: 0),
              loadingText: '',
              loadingIcon: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: context.colors.secondary,
                  ),
                ),
              ),
            ),
            child: SkeletonTheme(
              themeMode: ThemeMode.light,
              child: SafeArea(
                child: MaterialApp.router(
                  builder: EasyLoading.init(),
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
