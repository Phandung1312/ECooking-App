// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i16;
import 'package:uq_system_app/data/repositories/auth.repository.impl.dart'
    as _i65;
import 'package:uq_system_app/data/repositories/comment.repository.impl.dart'
    as _i25;
import 'package:uq_system_app/data/repositories/file.repository.impl.dart'
    as _i31;
import 'package:uq_system_app/data/repositories/notification.repository.impl.dart'
    as _i7;
import 'package:uq_system_app/data/repositories/recipe.repository.impl.dart'
    as _i11;
import 'package:uq_system_app/data/repositories/search.repository.impl.dart'
    as _i13;
import 'package:uq_system_app/data/repositories/system/system.repository.dart'
    as _i54;
import 'package:uq_system_app/data/repositories/system/system.repository.impl.dart'
    as _i55;
import 'package:uq_system_app/data/repositories/user.repository.impl.dart'
    as _i19;
import 'package:uq_system_app/data/services/api/api.service.dart' as _i3;
import 'package:uq_system_app/data/services/auth/auth.services.dart' as _i20;
import 'package:uq_system_app/data/services/auth/auth.services.impl.dart'
    as _i21;
import 'package:uq_system_app/data/sources/local/local.dart' as _i47;
import 'package:uq_system_app/data/sources/network/network.dart' as _i5;
import 'package:uq_system_app/data/usecases/logout.dart' as _i48;
import 'package:uq_system_app/data/usecases/save_language.dart' as _i72;
import 'package:uq_system_app/di/register_module.dart' as _i74;
import 'package:uq_system_app/domain/repositories/auth.repository.dart' as _i64;
import 'package:uq_system_app/domain/repositories/comment.repository.dart'
    as _i24;
import 'package:uq_system_app/domain/repositories/file.repository.dart' as _i30;
import 'package:uq_system_app/domain/repositories/notification.repository.dart'
    as _i6;
import 'package:uq_system_app/domain/repositories/recipe.repository.dart'
    as _i10;
import 'package:uq_system_app/domain/repositories/search.repository.dart'
    as _i12;
import 'package:uq_system_app/domain/repositories/user.repository.dart' as _i18;
import 'package:uq_system_app/domain/usecase/comment/create_comment.usecase.dart'
    as _i27;
import 'package:uq_system_app/domain/usecase/comment/get_comments.usecase.dart'
    as _i32;
import 'package:uq_system_app/domain/usecase/file/upload_image.usecase.dart'
    as _i58;
import 'package:uq_system_app/domain/usecase/file/upload_video.usecase.dart'
    as _i59;
import 'package:uq_system_app/domain/usecase/login.usecase.dart' as _i70;
import 'package:uq_system_app/domain/usecase/notification/count_unread_notifications.usecase.dart'
    as _i26;
import 'package:uq_system_app/domain/usecase/notification/get_notification.usecase.dart'
    as _i37;
import 'package:uq_system_app/domain/usecase/notification/get_notifications.usecase.dart'
    as _i38;
import 'package:uq_system_app/domain/usecase/notification/read_notification.usecase.dart'
    as _i9;
import 'package:uq_system_app/domain/usecase/recipe/change_recipe_favorite.usecase.dart'
    as _i22;
import 'package:uq_system_app/domain/usecase/recipe/change_saved_recipe.usecase.dart'
    as _i23;
import 'package:uq_system_app/domain/usecase/recipe/create_recipe.usecase.dart'
    as _i28;
import 'package:uq_system_app/domain/usecase/recipe/get_draft_recipes.usecase.dart'
    as _i33;
import 'package:uq_system_app/domain/usecase/recipe/get_recipe_details.usecase.dart'
    as _i39;
import 'package:uq_system_app/domain/usecase/recipe/get_recipes.usecase.dart'
    as _i40;
import 'package:uq_system_app/domain/usecase/recipe/get_saved_recipes.usecase.dart'
    as _i41;
import 'package:uq_system_app/domain/usecase/recipe/get_suggest_recipes.usecase.dart'
    as _i42;
import 'package:uq_system_app/domain/usecase/recipe/get_user_recipes.usecase.dart'
    as _i45;
import 'package:uq_system_app/domain/usecase/recipe/update_recipe.usecase.dart'
    as _i17;
import 'package:uq_system_app/domain/usecase/search/get_suggestions.usecase.dart'
    as _i43;
import 'package:uq_system_app/domain/usecase/search/search.usecase.dart'
    as _i14;
import 'package:uq_system_app/domain/usecase/user/get_followers.usecase.dart'
    as _i34;
import 'package:uq_system_app/domain/usecase/user/get_followings.usecase.dart'
    as _i35;
import 'package:uq_system_app/domain/usecase/user/get_member.usecase.dart'
    as _i36;
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart'
    as _i44;
import 'package:uq_system_app/domain/usecase/user/update_follow.usecase.dart'
    as _i56;
import 'package:uq_system_app/domain/usecase/user/update_profile.usecase.dart'
    as _i57;
import 'package:uq_system_app/helpers/user_info.helper.dart' as _i60;
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart' as _i73;
import 'package:uq_system_app/presentation/blocs/socket/socket.cubit.dart'
    as _i53;
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart'
    as _i66;
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_bloc.dart'
    as _i67;
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.bloc.dart'
    as _i29;
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart'
    as _i46;
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_bloc.dart'
    as _i49;
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart'
    as _i50;
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart'
    as _i52;
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_bloc.dart'
    as _i68;
import 'package:uq_system_app/presentation/pages/follow/follow_bloc.dart'
    as _i69;
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_bloc.dart'
    as _i8;
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_bloc.dart'
    as _i71;
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_bloc.dart'
    as _i51;
import 'package:uq_system_app/presentation/pages/settings/settings_bloc.dart'
    as _i15;
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_bloc.dart'
    as _i61;
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_bloc.dart'
    as _i62;
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart'
    as _i63;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.ApiServices>(
        () => registerModule.registerApiService());
    gh.lazySingleton<_i4.FlutterSecureStorage>(
        () => registerModule.getFlutterSecureStorage);
    gh.lazySingleton<_i5.NetworkDataSource>(
        () => registerModule.registerNetworkDataSource(gh<_i3.ApiServices>()));
    gh.lazySingleton<_i6.NotificationRepository>(() =>
        _i7.NotificationRepositoryImpl(
            networkDataSource: gh<_i5.NetworkDataSource>()));
    gh.factory<_i8.NotificationSettingsBloc>(
        () => _i8.NotificationSettingsBloc());
    gh.factory<_i9.ReadNotificationUseCase>(
        () => _i9.ReadNotificationUseCase(gh<_i6.NotificationRepository>()));
    gh.lazySingleton<_i10.RecipeRepository>(
        () => _i11.RecipeRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i12.SearchRepository>(
        () => _i13.SearchRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i14.SearchUseCase>(
        () => _i14.SearchUseCase(gh<_i12.SearchRepository>()));
    gh.factory<_i15.SettingsBloc>(() => _i15.SettingsBloc());
    await gh.lazySingletonAsync<_i16.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<String>(
      () => registerModule.registerKey(),
      instanceName: 'key',
    );
    gh.factory<_i17.UpdateRecipeUseCase>(
        () => _i17.UpdateRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.lazySingleton<_i18.UserRepository>(
        () => _i19.UserRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i20.AuthServices>(() => _i21.AuthServicesImpl(
          gh<_i4.FlutterSecureStorage>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.factory<_i22.ChangeRecipeFavorite>(
        () => _i22.ChangeRecipeFavorite(gh<_i10.RecipeRepository>()));
    gh.factory<_i23.ChangeSavedRecipeUseCase>(
        () => _i23.ChangeSavedRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.lazySingleton<_i24.CommentRepository>(
        () => _i25.CommentRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i26.CountUnreadNotificationsUseCase>(() =>
        _i26.CountUnreadNotificationsUseCase(
            repository: gh<_i6.NotificationRepository>()));
    gh.factory<_i27.CreateCommentUseCase>(
        () => _i27.CreateCommentUseCase(gh<_i24.CommentRepository>()));
    gh.factory<_i28.CreateRecipeUseCase>(
        () => _i28.CreateRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i29.DashboardBloc>(
        () => _i29.DashboardBloc(gh<_i26.CountUnreadNotificationsUseCase>()));
    gh.lazySingleton<_i30.FileRepository>(
        () => _i31.FileRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i32.GetCommentsUseCase>(
        () => _i32.GetCommentsUseCase(gh<_i24.CommentRepository>()));
    gh.factory<_i33.GetDraftRecipesUseCase>(
        () => _i33.GetDraftRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i34.GetFollowersUseCase>(
        () => _i34.GetFollowersUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i35.GetFollowingsUseCase>(
        () => _i35.GetFollowingsUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i36.GetMemberUseCase>(
        () => _i36.GetMemberUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i37.GetNotificationUseCase>(
        () => _i37.GetNotificationUseCase(gh<_i6.NotificationRepository>()));
    gh.factory<_i38.GetNotificationsUseCase>(
        () => _i38.GetNotificationsUseCase(gh<_i6.NotificationRepository>()));
    gh.factory<_i39.GetRecipeDetailsDetailsUseCase>(
        () => _i39.GetRecipeDetailsDetailsUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i40.GetRecipesUseCase>(
        () => _i40.GetRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i41.GetSavedRecipesUseCase>(
        () => _i41.GetSavedRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i42.GetSuggestRecipesUseCase>(
        () => _i42.GetSuggestRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i43.GetSuggestionsUseCase>(
        () => _i43.GetSuggestionsUseCase(gh<_i12.SearchRepository>()));
    gh.factory<_i44.GetTopMembersUseCase>(
        () => _i44.GetTopMembersUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i45.GetUserRecipesUseCase>(
        () => _i45.GetUserRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i46.HomeBloc>(() => _i46.HomeBloc(
          gh<_i40.GetRecipesUseCase>(),
          gh<_i44.GetTopMembersUseCase>(),
          gh<_i22.ChangeRecipeFavorite>(),
          gh<_i23.ChangeSavedRecipeUseCase>(),
        ));
    gh.lazySingleton<_i47.LocalDataSource>(() => _i47.LocalDataSource(
          gh<_i16.SharedPreferences>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.lazySingleton<_i48.Logout>(() => _i48.Logout(gh<_i20.AuthServices>()));
    gh.factory<_i49.NotificationBloc>(() => _i49.NotificationBloc(
          gh<_i38.GetNotificationsUseCase>(),
          gh<_i26.CountUnreadNotificationsUseCase>(),
          gh<_i9.ReadNotificationUseCase>(),
          gh<_i37.GetNotificationUseCase>(),
        ));
    gh.factory<_i50.ProfileBloc>(() => _i50.ProfileBloc(
          gh<_i36.GetMemberUseCase>(),
          gh<_i45.GetUserRecipesUseCase>(),
          gh<_i41.GetSavedRecipesUseCase>(),
          gh<_i23.ChangeSavedRecipeUseCase>(),
        ));
    gh.factory<_i51.SavedRecipesBloc>(
        () => _i51.SavedRecipesBloc(gh<_i33.GetDraftRecipesUseCase>()));
    gh.factory<_i52.SearchBloc>(() => _i52.SearchBloc(
          gh<_i43.GetSuggestionsUseCase>(),
          gh<_i14.SearchUseCase>(),
        ));
    gh.lazySingleton<_i53.SocketCubit>(
        () => _i53.SocketCubit(gh<_i20.AuthServices>()));
    gh.lazySingleton<_i54.SystemRepository>(
        () => _i55.SystemRepositoryImpl(gh<_i47.LocalDataSource>()));
    gh.factory<_i56.UpdateFollowUseCase>(
        () => _i56.UpdateFollowUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i57.UpdateProfileUseCase>(
        () => _i57.UpdateProfileUseCase(gh<_i18.UserRepository>()));
    gh.factory<_i58.UploadImageUseCase>(
        () => _i58.UploadImageUseCase(gh<_i30.FileRepository>()));
    gh.factory<_i59.UploadVideoUseCase>(
        () => _i59.UploadVideoUseCase(gh<_i30.FileRepository>()));
    gh.lazySingleton<_i60.UserInfoHelper>(() => _i60.UserInfoHelper(
          gh<_i20.AuthServices>(),
          gh<_i47.LocalDataSource>(),
        ));
    gh.factory<_i61.UserProfileBloc>(() => _i61.UserProfileBloc(
          gh<_i36.GetMemberUseCase>(),
          gh<_i45.GetUserRecipesUseCase>(),
          gh<_i56.UpdateFollowUseCase>(),
        ));
    gh.factory<_i62.ViewMoreMembersBloc>(() => _i62.ViewMoreMembersBloc(
          gh<_i44.GetTopMembersUseCase>(),
          gh<_i56.UpdateFollowUseCase>(),
        ));
    gh.factory<_i63.ViewMoreRecipesBloc>(
        () => _i63.ViewMoreRecipesBloc(gh<_i40.GetRecipesUseCase>()));
    gh.lazySingleton<_i64.AuthRepository>(() => _i65.AuthRepositoryImpl(
          gh<_i5.NetworkDataSource>(),
          gh<_i47.LocalDataSource>(),
        ));
    gh.factory<_i66.CommentBloc>(() => _i66.CommentBloc(
          gh<_i32.GetCommentsUseCase>(),
          gh<_i27.CreateCommentUseCase>(),
        ));
    gh.factory<_i67.CreateRecipeBloc>(() => _i67.CreateRecipeBloc(
          gh<_i28.CreateRecipeUseCase>(),
          gh<_i17.UpdateRecipeUseCase>(),
          gh<_i39.GetRecipeDetailsDetailsUseCase>(),
          gh<_i59.UploadVideoUseCase>(),
          gh<_i58.UploadImageUseCase>(),
        ));
    gh.factory<_i68.EditProfileBloc>(() => _i68.EditProfileBloc(
          gh<_i58.UploadImageUseCase>(),
          gh<_i57.UpdateProfileUseCase>(),
        ));
    gh.factory<_i69.FollowBloc>(() => _i69.FollowBloc(
          gh<_i34.GetFollowersUseCase>(),
          gh<_i35.GetFollowingsUseCase>(),
          gh<_i56.UpdateFollowUseCase>(),
        ));
    gh.lazySingleton<_i70.LoginUseCase>(
        () => _i70.LoginUseCase(gh<_i64.AuthRepository>()));
    gh.factory<_i71.RecipeDetailsBloc>(() => _i71.RecipeDetailsBloc(
          gh<_i39.GetRecipeDetailsDetailsUseCase>(),
          gh<_i42.GetSuggestRecipesUseCase>(),
          gh<_i32.GetCommentsUseCase>(),
          gh<_i22.ChangeRecipeFavorite>(),
          gh<_i23.ChangeSavedRecipeUseCase>(),
          gh<_i56.UpdateFollowUseCase>(),
        ));
    gh.lazySingleton<_i72.SaveLanguage>(
        () => _i72.SaveLanguage(gh<_i54.SystemRepository>()));
    gh.lazySingleton<_i73.AuthBloc>(() => _i73.AuthBloc(
          gh<_i48.Logout>(),
          gh<_i70.LoginUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i74.RegisterModule {}
