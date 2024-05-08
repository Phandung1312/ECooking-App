import 'package:auto_route/auto_route.dart';
import 'package:uq_system_app/presentation/pages/auth/login/login_screens.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home.dart';
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search.dart';
import 'package:uq_system_app/presentation/pages/splash/splash.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/splash', page: SplashRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/',page : DashboardRoute.page, children: [
      AutoRoute(path: 'home', page: HomeRoute.page),
      AutoRoute(path: 'search', page: SearchRoute.page),
      AutoRoute(path: 'create_recipe', page: CreateRecipeRoute.page),
      AutoRoute(path: 'notification', page: NotificationRoute.page),
      AutoRoute(path: 'profile', page: ProfileRoute.page),
    ]),
    AutoRoute(path: '/view_more_recipes', page: ViewMoreRecipesRoute.page),
      ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
}
