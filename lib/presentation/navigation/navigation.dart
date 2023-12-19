import 'package:auto_route/auto_route.dart';
import 'package:uq_system_app/presentation/pages/auth/login/login_screens.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home.dart';
import 'package:flutter/cupertino.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/', page: DashboardRoute.page, children: [
      AutoRoute(path: 'home', page: DashboardHomeRoute.page, initial: true),
      AutoRoute(path: 'account', page: DashboardAccountRoute.page),
    ]),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
}
