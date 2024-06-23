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
import 'package:shared_preferences/shared_preferences.dart' as _i18;
import 'package:uq_system_app/data/repositories/auth.repository.impl.dart'
    as _i69;
import 'package:uq_system_app/data/repositories/comment.repository.impl.dart'
    as _i27;
import 'package:uq_system_app/data/repositories/file.repository.impl.dart'
    as _i35;
import 'package:uq_system_app/data/repositories/notification.repository.impl.dart'
    as _i7;
import 'package:uq_system_app/data/repositories/recipe.repository.impl.dart'
    as _i11;
import 'package:uq_system_app/data/repositories/report.repository.impl.dart'
    as _i13;
import 'package:uq_system_app/data/repositories/search.repository.impl.dart'
    as _i15;
import 'package:uq_system_app/data/repositories/system/system.repository.dart'
    as _i58;
import 'package:uq_system_app/data/repositories/system/system.repository.impl.dart'
    as _i59;
import 'package:uq_system_app/data/repositories/user.repository.impl.dart'
    as _i21;
import 'package:uq_system_app/data/services/api/api.service.dart' as _i3;
import 'package:uq_system_app/data/services/auth/auth.services.dart' as _i22;
import 'package:uq_system_app/data/services/auth/auth.services.impl.dart'
    as _i23;
import 'package:uq_system_app/data/sources/local/local.dart' as _i51;
import 'package:uq_system_app/data/sources/network/network.dart' as _i5;
import 'package:uq_system_app/data/usecases/logout.dart' as _i52;
import 'package:uq_system_app/data/usecases/save_language.dart' as _i77;
import 'package:uq_system_app/di/register_module.dart' as _i79;
import 'package:uq_system_app/domain/repositories/auth.repository.dart' as _i68;
import 'package:uq_system_app/domain/repositories/comment.repository.dart'
    as _i26;
import 'package:uq_system_app/domain/repositories/file.repository.dart' as _i34;
import 'package:uq_system_app/domain/repositories/notification.repository.dart'
    as _i6;
import 'package:uq_system_app/domain/repositories/recipe.repository.dart'
    as _i10;
import 'package:uq_system_app/domain/repositories/report.repository.dart'
    as _i12;
import 'package:uq_system_app/domain/repositories/search.repository.dart'
    as _i14;
import 'package:uq_system_app/domain/repositories/user.repository.dart' as _i20;
import 'package:uq_system_app/domain/usecase/comment/create_comment.usecase.dart'
    as _i29;
import 'package:uq_system_app/domain/usecase/comment/get_comments.usecase.dart'
    as _i36;
import 'package:uq_system_app/domain/usecase/file/upload_image.usecase.dart'
    as _i62;
import 'package:uq_system_app/domain/usecase/file/upload_video.usecase.dart'
    as _i63;
import 'package:uq_system_app/domain/usecase/login.usecase.dart' as _i74;
import 'package:uq_system_app/domain/usecase/logout.usecase.dart' as _i75;
import 'package:uq_system_app/domain/usecase/notification/count_unread_notifications.usecase.dart'
    as _i28;
import 'package:uq_system_app/domain/usecase/notification/get_notification.usecase.dart'
    as _i41;
import 'package:uq_system_app/domain/usecase/notification/get_notifications.usecase.dart'
    as _i42;
import 'package:uq_system_app/domain/usecase/notification/read_notification.usecase.dart'
    as _i9;
import 'package:uq_system_app/domain/usecase/recipe/change_recipe_favorite.usecase.dart'
    as _i24;
import 'package:uq_system_app/domain/usecase/recipe/change_saved_recipe.usecase.dart'
    as _i25;
import 'package:uq_system_app/domain/usecase/recipe/create_recipe.usecase.dart'
    as _i30;
import 'package:uq_system_app/domain/usecase/recipe/delete_recipe.usecase.dart'
    as _i33;
import 'package:uq_system_app/domain/usecase/recipe/get_draft_recipes.usecase.dart'
    as _i37;
import 'package:uq_system_app/domain/usecase/recipe/get_recipe_details.usecase.dart'
    as _i43;
import 'package:uq_system_app/domain/usecase/recipe/get_recipes.usecase.dart'
    as _i44;
import 'package:uq_system_app/domain/usecase/recipe/get_saved_recipes.usecase.dart'
    as _i45;
import 'package:uq_system_app/domain/usecase/recipe/get_suggest_recipes.usecase.dart'
    as _i46;
import 'package:uq_system_app/domain/usecase/recipe/get_user_recipes.usecase.dart'
    as _i49;
import 'package:uq_system_app/domain/usecase/recipe/update_recipe.usecase.dart'
    as _i19;
import 'package:uq_system_app/domain/usecase/report/report.usecase.dart'
    as _i31;
import 'package:uq_system_app/domain/usecase/search/get_suggestions.usecase.dart'
    as _i47;
import 'package:uq_system_app/domain/usecase/search/search.usecase.dart'
    as _i16;
import 'package:uq_system_app/domain/usecase/user/get_followers.usecase.dart'
    as _i38;
import 'package:uq_system_app/domain/usecase/user/get_followings.usecase.dart'
    as _i39;
import 'package:uq_system_app/domain/usecase/user/get_member.usecase.dart'
    as _i40;
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart'
    as _i48;
import 'package:uq_system_app/domain/usecase/user/update_follow.usecase.dart'
    as _i60;
import 'package:uq_system_app/domain/usecase/user/update_profile.usecase.dart'
    as _i61;
import 'package:uq_system_app/helpers/user_info.helper.dart' as _i64;
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart' as _i78;
import 'package:uq_system_app/presentation/blocs/socket/socket.cubit.dart'
    as _i57;
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart'
    as _i70;
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_bloc.dart'
    as _i71;
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.bloc.dart'
    as _i32;
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart'
    as _i50;
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_bloc.dart'
    as _i53;
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart'
    as _i54;
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart'
    as _i56;
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_bloc.dart'
    as _i72;
import 'package:uq_system_app/presentation/pages/follow/follow_bloc.dart'
    as _i73;
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_bloc.dart'
    as _i8;
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_bloc.dart'
    as _i76;
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_bloc.dart'
    as _i55;
import 'package:uq_system_app/presentation/pages/settings/settings_bloc.dart'
    as _i17;
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_bloc.dart'
    as _i65;
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_bloc.dart'
    as _i66;
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart'
    as _i67;

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
    gh.lazySingleton<_i12.ReportRepository>(
        () => _i13.ReportRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i14.SearchRepository>(
        () => _i15.SearchRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i16.SearchUseCase>(
        () => _i16.SearchUseCase(gh<_i14.SearchRepository>()));
    gh.factory<_i17.SettingsBloc>(() => _i17.SettingsBloc());
    await gh.lazySingletonAsync<_i18.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<String>(
      () => registerModule.registerKey(),
      instanceName: 'key',
    );
    gh.factory<_i19.UpdateRecipeUseCase>(
        () => _i19.UpdateRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.lazySingleton<_i20.UserRepository>(
        () => _i21.UserRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i22.AuthServices>(() => _i23.AuthServicesImpl(
          gh<_i4.FlutterSecureStorage>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.factory<_i24.ChangeRecipeFavorite>(
        () => _i24.ChangeRecipeFavorite(gh<_i10.RecipeRepository>()));
    gh.factory<_i25.ChangeSavedRecipeUseCase>(
        () => _i25.ChangeSavedRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.lazySingleton<_i26.CommentRepository>(
        () => _i27.CommentRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i28.CountUnreadNotificationsUseCase>(() =>
        _i28.CountUnreadNotificationsUseCase(
            repository: gh<_i6.NotificationRepository>()));
    gh.factory<_i29.CreateCommentUseCase>(
        () => _i29.CreateCommentUseCase(gh<_i26.CommentRepository>()));
    gh.factory<_i30.CreateRecipeUseCase>(
        () => _i30.CreateRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i31.CreateReportUseCase>(
        () => _i31.CreateReportUseCase(gh<_i12.ReportRepository>()));
    gh.factory<_i32.DashboardBloc>(
        () => _i32.DashboardBloc(gh<_i28.CountUnreadNotificationsUseCase>()));
    gh.factory<_i33.DeleteRecipeUseCase>(
        () => _i33.DeleteRecipeUseCase(gh<_i10.RecipeRepository>()));
    gh.lazySingleton<_i34.FileRepository>(
        () => _i35.FileRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i36.GetCommentsUseCase>(
        () => _i36.GetCommentsUseCase(gh<_i26.CommentRepository>()));
    gh.factory<_i37.GetDraftRecipesUseCase>(
        () => _i37.GetDraftRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i38.GetFollowersUseCase>(
        () => _i38.GetFollowersUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i39.GetFollowingsUseCase>(
        () => _i39.GetFollowingsUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i40.GetMemberUseCase>(
        () => _i40.GetMemberUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i41.GetNotificationUseCase>(
        () => _i41.GetNotificationUseCase(gh<_i6.NotificationRepository>()));
    gh.factory<_i42.GetNotificationsUseCase>(
        () => _i42.GetNotificationsUseCase(gh<_i6.NotificationRepository>()));
    gh.factory<_i43.GetRecipeDetailsDetailsUseCase>(
        () => _i43.GetRecipeDetailsDetailsUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i44.GetRecipesUseCase>(
        () => _i44.GetRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i45.GetSavedRecipesUseCase>(
        () => _i45.GetSavedRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i46.GetSuggestRecipesUseCase>(
        () => _i46.GetSuggestRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i47.GetSuggestionsUseCase>(
        () => _i47.GetSuggestionsUseCase(gh<_i14.SearchRepository>()));
    gh.factory<_i48.GetTopMembersUseCase>(
        () => _i48.GetTopMembersUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i49.GetUserRecipesUseCase>(
        () => _i49.GetUserRecipesUseCase(gh<_i10.RecipeRepository>()));
    gh.factory<_i50.HomeBloc>(() => _i50.HomeBloc(
          gh<_i44.GetRecipesUseCase>(),
          gh<_i48.GetTopMembersUseCase>(),
          gh<_i24.ChangeRecipeFavorite>(),
          gh<_i25.ChangeSavedRecipeUseCase>(),
        ));
    gh.lazySingleton<_i51.LocalDataSource>(() => _i51.LocalDataSource(
          gh<_i18.SharedPreferences>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.lazySingleton<_i52.Logout>(() => _i52.Logout(gh<_i22.AuthServices>()));
    gh.factory<_i53.NotificationBloc>(() => _i53.NotificationBloc(
          gh<_i42.GetNotificationsUseCase>(),
          gh<_i28.CountUnreadNotificationsUseCase>(),
          gh<_i9.ReadNotificationUseCase>(),
          gh<_i41.GetNotificationUseCase>(),
        ));
    gh.factory<_i54.ProfileBloc>(() => _i54.ProfileBloc(
          gh<_i40.GetMemberUseCase>(),
          gh<_i49.GetUserRecipesUseCase>(),
          gh<_i45.GetSavedRecipesUseCase>(),
          gh<_i25.ChangeSavedRecipeUseCase>(),
        ));
    gh.factory<_i55.SavedRecipesBloc>(
        () => _i55.SavedRecipesBloc(gh<_i37.GetDraftRecipesUseCase>()));
    gh.factory<_i56.SearchBloc>(() => _i56.SearchBloc(
          gh<_i47.GetSuggestionsUseCase>(),
          gh<_i16.SearchUseCase>(),
        ));
    gh.lazySingleton<_i57.SocketCubit>(
        () => _i57.SocketCubit(gh<_i22.AuthServices>()));
    gh.lazySingleton<_i58.SystemRepository>(
        () => _i59.SystemRepositoryImpl(gh<_i51.LocalDataSource>()));
    gh.factory<_i60.UpdateFollowUseCase>(
        () => _i60.UpdateFollowUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i61.UpdateProfileUseCase>(
        () => _i61.UpdateProfileUseCase(gh<_i20.UserRepository>()));
    gh.factory<_i62.UploadImageUseCase>(
        () => _i62.UploadImageUseCase(gh<_i34.FileRepository>()));
    gh.factory<_i63.UploadVideoUseCase>(
        () => _i63.UploadVideoUseCase(gh<_i34.FileRepository>()));
    gh.lazySingleton<_i64.UserInfoHelper>(() => _i64.UserInfoHelper(
          gh<_i22.AuthServices>(),
          gh<_i51.LocalDataSource>(),
        ));
    gh.factory<_i65.UserProfileBloc>(() => _i65.UserProfileBloc(
          gh<_i40.GetMemberUseCase>(),
          gh<_i49.GetUserRecipesUseCase>(),
          gh<_i60.UpdateFollowUseCase>(),
        ));
    gh.factory<_i66.ViewMoreMembersBloc>(() => _i66.ViewMoreMembersBloc(
          gh<_i48.GetTopMembersUseCase>(),
          gh<_i60.UpdateFollowUseCase>(),
        ));
    gh.factory<_i67.ViewMoreRecipesBloc>(
        () => _i67.ViewMoreRecipesBloc(gh<_i44.GetRecipesUseCase>()));
    gh.lazySingleton<_i68.AuthRepository>(() => _i69.AuthRepositoryImpl(
          gh<_i5.NetworkDataSource>(),
          gh<_i51.LocalDataSource>(),
          gh<_i22.AuthServices>(),
        ));
    gh.factory<_i70.CommentBloc>(() => _i70.CommentBloc(
          gh<_i36.GetCommentsUseCase>(),
          gh<_i29.CreateCommentUseCase>(),
        ));
    gh.factory<_i71.CreateRecipeBloc>(() => _i71.CreateRecipeBloc(
          gh<_i30.CreateRecipeUseCase>(),
          gh<_i19.UpdateRecipeUseCase>(),
          gh<_i43.GetRecipeDetailsDetailsUseCase>(),
          gh<_i63.UploadVideoUseCase>(),
          gh<_i62.UploadImageUseCase>(),
          gh<_i33.DeleteRecipeUseCase>(),
        ));
    gh.factory<_i72.EditProfileBloc>(() => _i72.EditProfileBloc(
          gh<_i62.UploadImageUseCase>(),
          gh<_i61.UpdateProfileUseCase>(),
        ));
    gh.factory<_i73.FollowBloc>(() => _i73.FollowBloc(
          gh<_i38.GetFollowersUseCase>(),
          gh<_i39.GetFollowingsUseCase>(),
          gh<_i60.UpdateFollowUseCase>(),
        ));
    gh.lazySingleton<_i74.LoginUseCase>(
        () => _i74.LoginUseCase(gh<_i68.AuthRepository>()));
    gh.factory<_i75.LogoutUseCase>(
        () => _i75.LogoutUseCase(gh<_i68.AuthRepository>()));
    gh.factory<_i76.RecipeDetailsBloc>(() => _i76.RecipeDetailsBloc(
          gh<_i43.GetRecipeDetailsDetailsUseCase>(),
          gh<_i46.GetSuggestRecipesUseCase>(),
          gh<_i36.GetCommentsUseCase>(),
          gh<_i24.ChangeRecipeFavorite>(),
          gh<_i25.ChangeSavedRecipeUseCase>(),
          gh<_i60.UpdateFollowUseCase>(),
          gh<_i33.DeleteRecipeUseCase>(),
          gh<_i31.CreateReportUseCase>(),
        ));
    gh.lazySingleton<_i77.SaveLanguage>(
        () => _i77.SaveLanguage(gh<_i58.SystemRepository>()));
    gh.lazySingleton<_i78.AuthBloc>(() => _i78.AuthBloc(
          gh<_i75.LogoutUseCase>(),
          gh<_i74.LoginUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i79.RegisterModule {}
