import 'package:auto_route/auto_route.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';
import 'package:uq_system_app/presentation/pages/auth/login/login_screens.dart';
import 'package:uq_system_app/presentation/pages/comment/comment.dart';
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home.dart';
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile.dart';
import 'package:uq_system_app/presentation/pages/follow/follow.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes.dart';
import 'package:uq_system_app/presentation/pages/settings/settings.dart';
import 'package:uq_system_app/presentation/pages/splash/splash.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/splash', page: SplashRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(
      path: '/',
      page: DashboardRoute.page,
      children: [
        AutoRoute(path: 'home', page: HomeRoute.page),
        AutoRoute(path: 'search', page: SearchRoute.page),
        AutoRoute(path: 'saved_recipes', page: SavedRecipesRoute.page),
        AutoRoute(path: 'notification', page: NotificationRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    AutoRoute(path: '/create_recipe', page: CreateRecipeRoute.page),
    AutoRoute(path: '/profile', page: ProfileRoute.page),
    AutoRoute(path: '/view_more_recipes', page: ViewMoreRecipesRoute.page),
    AutoRoute(path: '/view_more_members', page: ViewMoreMembersRoute.page),
    AutoRoute(path: '/member_profile', page: UserProfileRoute.page),
    AutoRoute(path: '/recipe_details', page: RecipeDetailsRoute.page),
    AutoRoute(path: '/comment', page: CommentRoute.page),
    AutoRoute(path: '/follow', page: FollowRoute.page),
    AutoRoute(path: '/edit_profile', page: EditProfileRoute.page),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
    AutoRoute(path: '/notification_settings', page: NotificationSettingsRoute.page),

  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
}
