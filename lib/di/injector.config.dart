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
import 'package:shared_preferences/shared_preferences.dart' as _i13;
import 'package:uq_system_app/data/repositories/auth.repository.impl.dart'
    as _i37;
import 'package:uq_system_app/data/repositories/comment.repository.impl.dart'
    as _i19;
import 'package:uq_system_app/data/repositories/recipe.repository.impl.dart'
    as _i9;
import 'package:uq_system_app/data/repositories/search.repository.impl.dart'
    as _i11;
import 'package:uq_system_app/data/repositories/system/system.repository.dart'
    as _i32;
import 'package:uq_system_app/data/repositories/system/system.repository.impl.dart'
    as _i33;
import 'package:uq_system_app/data/repositories/user.repository.impl.dart'
    as _i15;
import 'package:uq_system_app/data/services/api/api.service.dart' as _i3;
import 'package:uq_system_app/data/services/auth/auth.services.dart' as _i16;
import 'package:uq_system_app/data/services/auth/auth.services.impl.dart'
    as _i17;
import 'package:uq_system_app/data/sources/local/local.dart' as _i28;
import 'package:uq_system_app/data/sources/network/network.dart' as _i5;
import 'package:uq_system_app/data/usecases/logout.dart' as _i29;
import 'package:uq_system_app/data/usecases/save_language.dart' as _i41;
import 'package:uq_system_app/di/register_module.dart' as _i43;
import 'package:uq_system_app/domain/repositories/auth.repository.dart' as _i36;
import 'package:uq_system_app/domain/repositories/comment.repository.dart'
    as _i18;
import 'package:uq_system_app/domain/repositories/recipe.repository.dart'
    as _i8;
import 'package:uq_system_app/domain/repositories/search.repository.dart'
    as _i10;
import 'package:uq_system_app/domain/repositories/user.repository.dart' as _i14;
import 'package:uq_system_app/domain/usecase/comment/get_comments.usecase.dart'
    as _i21;
import 'package:uq_system_app/domain/usecase/login.usecase.dart' as _i40;
import 'package:uq_system_app/domain/usecase/recipe/create_recipe.usecase.dart'
    as _i20;
import 'package:uq_system_app/domain/usecase/recipe/get_recipe_details.usecase.dart'
    as _i22;
import 'package:uq_system_app/domain/usecase/recipe/get_recipes.usecase.dart'
    as _i23;
import 'package:uq_system_app/domain/usecase/recipe/get_suggest_recipes.usecase.dart'
    as _i24;
import 'package:uq_system_app/domain/usecase/search/get_suggestions.usecase.dart'
    as _i25;
import 'package:uq_system_app/domain/usecase/search/search.usecase.dart'
    as _i12;
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart'
    as _i26;
import 'package:uq_system_app/helpers/user_info.helper.dart' as _i34;
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart' as _i42;
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart'
    as _i38;
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_bloc.dart'
    as _i39;
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart'
    as _i27;
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_bloc.dart'
    as _i6;
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart'
    as _i7;
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart'
    as _i31;
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_bloc.dart'
    as _i30;
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart'
    as _i35;

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
    gh.factory<_i6.NotificationBloc>(() => _i6.NotificationBloc());
    gh.factory<_i7.ProfileBloc>(() => _i7.ProfileBloc());
    gh.lazySingleton<_i8.RecipeRepository>(
        () => _i9.RecipeRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i10.SearchRepository>(
        () => _i11.SearchRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i12.SearchUseCase>(
        () => _i12.SearchUseCase(gh<_i10.SearchRepository>()));
    await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<String>(
      () => registerModule.registerKey(),
      instanceName: 'key',
    );
    gh.lazySingleton<_i14.UserRepository>(
        () => _i15.UserRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.lazySingleton<_i16.AuthServices>(() => _i17.AuthServicesImpl(
          gh<_i4.FlutterSecureStorage>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.lazySingleton<_i18.CommentRepository>(
        () => _i19.CommentRepositoryImpl(gh<_i5.NetworkDataSource>()));
    gh.factory<_i20.CreateRecipeUseCase>(
        () => _i20.CreateRecipeUseCase(gh<_i8.RecipeRepository>()));
    gh.factory<_i21.GetCommentsUseCase>(
        () => _i21.GetCommentsUseCase(gh<_i18.CommentRepository>()));
    gh.factory<_i22.GetRecipeDetailsDetailsUseCase>(
        () => _i22.GetRecipeDetailsDetailsUseCase(gh<_i8.RecipeRepository>()));
    gh.factory<_i23.GetRecipesUseCase>(
        () => _i23.GetRecipesUseCase(gh<_i8.RecipeRepository>()));
    gh.factory<_i24.GetSuggestRecipesUseCase>(
        () => _i24.GetSuggestRecipesUseCase(gh<_i8.RecipeRepository>()));
    gh.factory<_i25.GetSuggestionsUseCase>(
        () => _i25.GetSuggestionsUseCase(gh<_i10.SearchRepository>()));
    gh.factory<_i26.GetTopMembersUseCase>(
        () => _i26.GetTopMembersUseCase(gh<_i14.UserRepository>()));
    gh.factory<_i27.HomeBloc>(() => _i27.HomeBloc(
          gh<_i23.GetRecipesUseCase>(),
          gh<_i26.GetTopMembersUseCase>(),
        ));
    gh.lazySingleton<_i28.LocalDataSource>(() => _i28.LocalDataSource(
          gh<_i13.SharedPreferences>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.lazySingleton<_i29.Logout>(() => _i29.Logout(gh<_i16.AuthServices>()));
    gh.factory<_i30.RecipeDetailsBloc>(() => _i30.RecipeDetailsBloc(
          gh<_i22.GetRecipeDetailsDetailsUseCase>(),
          gh<_i24.GetSuggestRecipesUseCase>(),
          gh<_i21.GetCommentsUseCase>(),
        ));
    gh.factory<_i31.SearchBloc>(() => _i31.SearchBloc(
          gh<_i25.GetSuggestionsUseCase>(),
          gh<_i12.SearchUseCase>(),
        ));
    gh.lazySingleton<_i32.SystemRepository>(
        () => _i33.SystemRepositoryImpl(gh<_i28.LocalDataSource>()));
    gh.lazySingleton<_i34.UserInfoHelper>(() => _i34.UserInfoHelper(
          gh<_i16.AuthServices>(),
          gh<_i28.LocalDataSource>(),
        ));
    gh.factory<_i35.ViewMoreRecipesBloc>(
        () => _i35.ViewMoreRecipesBloc(gh<_i23.GetRecipesUseCase>()));
    gh.lazySingleton<_i36.AuthRepository>(() => _i37.AuthRepositoryImpl(
          gh<_i5.NetworkDataSource>(),
          gh<_i28.LocalDataSource>(),
        ));
    gh.factory<_i38.CommentBloc>(
        () => _i38.CommentBloc(gh<_i21.GetCommentsUseCase>()));
    gh.factory<_i39.CreateRecipeBloc>(
        () => _i39.CreateRecipeBloc(gh<_i20.CreateRecipeUseCase>()));
    gh.lazySingleton<_i40.LoginUseCase>(
        () => _i40.LoginUseCase(gh<_i36.AuthRepository>()));
    gh.lazySingleton<_i41.SaveLanguage>(
        () => _i41.SaveLanguage(gh<_i32.SystemRepository>()));
    gh.lazySingleton<_i42.AuthBloc>(() => _i42.AuthBloc(
          gh<_i29.Logout>(),
          gh<_i40.LoginUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i43.RegisterModule {}
