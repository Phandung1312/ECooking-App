// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'navigation.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CommentRoute.name: (routeData) {
      final args = routeData.argsAs<CommentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CommentPage(
          args.recipeId,
          args.isWriteComment,
        ),
      );
    },
    CreateRecipeRoute.name: (routeData) {
      final args = routeData.argsAs<CreateRecipeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateRecipePage(recipeId: args.recipeId),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfilePage(profile: args.profile),
      );
    },
    FollowRoute.name: (routeData) {
      final args = routeData.argsAs<FollowRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FollowPage(
          userId: args.userId,
          displayName: args.displayName,
          isViewFollowers: args.isViewFollowers,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotificationPage(),
      );
    },
    NotificationSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotificationSettingsPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfilePage(isFromDashboard: args.isFromDashboard),
      );
    },
    RecipeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecipeDetailsPage(
          id: args.id,
          instructionOrder: args.instructionOrder,
        ),
      );
    },
    SavedRecipesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SavedRecipesPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfilePage(userId: args.userId),
      );
    },
    ViewMoreMembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewMoreMembersPage(),
      );
    },
    ViewMoreRecipesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewMoreRecipesPage(),
      );
    },
  };
}

/// generated route for
/// [CommentPage]
class CommentRoute extends PageRouteInfo<CommentRouteArgs> {
  CommentRoute({
    required int recipeId,
    required bool isWriteComment,
    List<PageRouteInfo>? children,
  }) : super(
          CommentRoute.name,
          args: CommentRouteArgs(
            recipeId: recipeId,
            isWriteComment: isWriteComment,
          ),
          initialChildren: children,
        );

  static const String name = 'CommentRoute';

  static const PageInfo<CommentRouteArgs> page =
      PageInfo<CommentRouteArgs>(name);
}

class CommentRouteArgs {
  const CommentRouteArgs({
    required this.recipeId,
    required this.isWriteComment,
  });

  final int recipeId;

  final bool isWriteComment;

  @override
  String toString() {
    return 'CommentRouteArgs{recipeId: $recipeId, isWriteComment: $isWriteComment}';
  }
}

/// generated route for
/// [CreateRecipePage]
class CreateRecipeRoute extends PageRouteInfo<CreateRecipeRouteArgs> {
  CreateRecipeRoute({
    required int? recipeId,
    List<PageRouteInfo>? children,
  }) : super(
          CreateRecipeRoute.name,
          args: CreateRecipeRouteArgs(recipeId: recipeId),
          initialChildren: children,
        );

  static const String name = 'CreateRecipeRoute';

  static const PageInfo<CreateRecipeRouteArgs> page =
      PageInfo<CreateRecipeRouteArgs>(name);
}

class CreateRecipeRouteArgs {
  const CreateRecipeRouteArgs({required this.recipeId});

  final int? recipeId;

  @override
  String toString() {
    return 'CreateRecipeRouteArgs{recipeId: $recipeId}';
  }
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    required MemberDetails profile,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(profile: profile),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({required this.profile});

  final MemberDetails profile;

  @override
  String toString() {
    return 'EditProfileRouteArgs{profile: $profile}';
  }
}

/// generated route for
/// [FollowPage]
class FollowRoute extends PageRouteInfo<FollowRouteArgs> {
  FollowRoute({
    required int userId,
    required String displayName,
    required bool isViewFollowers,
    List<PageRouteInfo>? children,
  }) : super(
          FollowRoute.name,
          args: FollowRouteArgs(
            userId: userId,
            displayName: displayName,
            isViewFollowers: isViewFollowers,
          ),
          initialChildren: children,
        );

  static const String name = 'FollowRoute';

  static const PageInfo<FollowRouteArgs> page = PageInfo<FollowRouteArgs>(name);
}

class FollowRouteArgs {
  const FollowRouteArgs({
    required this.userId,
    required this.displayName,
    required this.isViewFollowers,
  });

  final int userId;

  final String displayName;

  final bool isViewFollowers;

  @override
  String toString() {
    return 'FollowRouteArgs{userId: $userId, displayName: $displayName, isViewFollowers: $isViewFollowers}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationPage]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationSettingsPage]
class NotificationSettingsRoute extends PageRouteInfo<void> {
  const NotificationSettingsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    bool isFromDashboard = true,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(isFromDashboard: isFromDashboard),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.isFromDashboard = true});

  final bool isFromDashboard;

  @override
  String toString() {
    return 'ProfileRouteArgs{isFromDashboard: $isFromDashboard}';
  }
}

/// generated route for
/// [RecipeDetailsPage]
class RecipeDetailsRoute extends PageRouteInfo<RecipeDetailsRouteArgs> {
  RecipeDetailsRoute({
    required int id,
    int? instructionOrder,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeDetailsRoute.name,
          args: RecipeDetailsRouteArgs(
            id: id,
            instructionOrder: instructionOrder,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeDetailsRoute';

  static const PageInfo<RecipeDetailsRouteArgs> page =
      PageInfo<RecipeDetailsRouteArgs>(name);
}

class RecipeDetailsRouteArgs {
  const RecipeDetailsRouteArgs({
    required this.id,
    this.instructionOrder,
  });

  final int id;

  final int? instructionOrder;

  @override
  String toString() {
    return 'RecipeDetailsRouteArgs{id: $id, instructionOrder: $instructionOrder}';
  }
}

/// generated route for
/// [SavedRecipesPage]
class SavedRecipesRoute extends PageRouteInfo<void> {
  const SavedRecipesRoute({List<PageRouteInfo>? children})
      : super(
          SavedRecipesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SavedRecipesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserProfilePage]
class UserProfileRoute extends PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(userId: userId),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<UserProfileRouteArgs> page =
      PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({required this.userId});

  final int userId;

  @override
  String toString() {
    return 'UserProfileRouteArgs{userId: $userId}';
  }
}

/// generated route for
/// [ViewMoreMembersPage]
class ViewMoreMembersRoute extends PageRouteInfo<void> {
  const ViewMoreMembersRoute({List<PageRouteInfo>? children})
      : super(
          ViewMoreMembersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewMoreMembersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ViewMoreRecipesPage]
class ViewMoreRecipesRoute extends PageRouteInfo<void> {
  const ViewMoreRecipesRoute({List<PageRouteInfo>? children})
      : super(
          ViewMoreRecipesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewMoreRecipesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
