// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;
import 'package:uq_system_app/data/repositories/auth.repository.impl.dart'
    as _i16;
import 'package:uq_system_app/data/repositories/recipe.repository.impl.dart'
    as _i10;
import 'package:uq_system_app/data/repositories/system/system.repository.dart'
    as _i25;
import 'package:uq_system_app/data/repositories/system/system.repository.impl.dart'
    as _i26;
import 'package:uq_system_app/data/repositories/user.repository.impl.dart'
    as _i14;
import 'package:uq_system_app/data/services/api/api.service.dart' as _i3;
import 'package:uq_system_app/data/services/auth/auth.services.dart' as _i17;
import 'package:uq_system_app/data/services/auth/auth.services.impl.dart'
    as _i18;
import 'package:uq_system_app/data/sources/local/local.dart' as _i22;
import 'package:uq_system_app/data/sources/network/network.dart' as _i6;
import 'package:uq_system_app/data/usecases/logout.dart' as _i24;
import 'package:uq_system_app/data/usecases/save_language.dart' as _i29;
import 'package:uq_system_app/di/register_module.dart' as _i30;
import 'package:uq_system_app/domain/repositories/auth.repository.dart' as _i15;
import 'package:uq_system_app/domain/repositories/recipe.repository.dart'
    as _i9;
import 'package:uq_system_app/domain/repositories/user.repository.dart' as _i13;
import 'package:uq_system_app/domain/usecase/login.usecase.dart' as _i23;
import 'package:uq_system_app/domain/usecase/recipe/get_recipes.usecase.dart'
    as _i19;
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart'
    as _i20;
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart' as _i28;
import 'package:uq_system_app/presentation/pages/dashboard/create_recipe/create_recipe_bloc.dart'
    as _i4;
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart'
    as _i21;
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_bloc.dart'
    as _i7;
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart'
    as _i8;
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart'
    as _i11;
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart'
    as _i27;

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
    gh.factory<_i4.CreateRecipeBloc>(() => _i4.CreateRecipeBloc());
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => registerModule.getFlutterSecureStorage);
    gh.lazySingleton<_i6.NetworkDataSource>(
        () => registerModule.registerNetworkDataSource(gh<_i3.ApiServices>()));
    gh.factory<_i7.NotificationBloc>(() => _i7.NotificationBloc());
    gh.factory<_i8.ProfileBloc>(() => _i8.ProfileBloc());
    gh.lazySingleton<_i9.RecipeRepository>(
        () => _i10.RecipeRepositoryImpl(gh<_i6.NetworkDataSource>()));
    gh.factory<_i11.SearchBloc>(() => _i11.SearchBloc());
    await gh.lazySingletonAsync<_i12.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<String>(
      () => registerModule.registerKey(),
      instanceName: 'key',
    );
    gh.lazySingleton<_i13.UserRepository>(
        () => _i14.UserRepositoryImpl(gh<_i6.NetworkDataSource>()));
    gh.lazySingleton<_i15.AuthRepository>(
        () => _i16.AuthRepositoryImpl(gh<_i6.NetworkDataSource>()));
    gh.lazySingleton<_i17.AuthServices>(() => _i18.AuthServicesImpl(
          gh<_i5.FlutterSecureStorage>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.factory<_i19.GetRecipesUseCase>(
        () => _i19.GetRecipesUseCase(gh<_i9.RecipeRepository>()));
    gh.factory<_i20.GetTopMembersUseCase>(
        () => _i20.GetTopMembersUseCase(gh<_i13.UserRepository>()));
    gh.factory<_i21.HomeBloc>(() => _i21.HomeBloc(
          gh<_i19.GetRecipesUseCase>(),
          gh<_i20.GetTopMembersUseCase>(),
        ));
    gh.lazySingleton<_i22.LocalDataSource>(() => _i22.LocalDataSource(
          gh<_i12.SharedPreferences>(),
          gh<String>(instanceName: 'key'),
        ));
    gh.lazySingleton<_i23.LoginUseCase>(
        () => _i23.LoginUseCase(gh<_i15.AuthRepository>()));
    gh.lazySingleton<_i24.Logout>(() => _i24.Logout(gh<_i17.AuthServices>()));
    gh.lazySingleton<_i25.SystemRepository>(
        () => _i26.SystemRepositoryImpl(gh<_i22.LocalDataSource>()));
    gh.factory<_i27.ViewMoreRecipesBloc>(
        () => _i27.ViewMoreRecipesBloc(gh<_i19.GetRecipesUseCase>()));
    gh.lazySingleton<_i28.AuthBloc>(() => _i28.AuthBloc(
          gh<_i24.Logout>(),
          gh<_i23.LoginUseCase>(),
        ));
    gh.lazySingleton<_i29.SaveLanguage>(
        () => _i29.SaveLanguage(gh<_i25.SystemRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i30.RegisterModule {}
