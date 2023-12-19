import 'package:dio/dio.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/core/exceptions/unauthorized_exception.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/system/system_bloc.dart';
import 'package:uq_system_app/presentation/blocs/system/system_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  AuthBloc get _authBloc => provider.get<AuthBloc>();

  SystemBloc get _systemBloc => provider.get<SystemBloc>();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    if (bloc is SystemBloc && change is Change<SystemState>) {
      _onSystemBlocChanged(bloc, change);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final actualError = error is BaseException ? error.data : error;

    if (error is UnauthorizedException ||
        (actualError is DioException &&
            actualError.response?.statusCode == 401)) {
      _authBloc.add(const AuthLoggedOut());
    }

    super.onError(bloc, error, stackTrace);
  }

  void _onSystemBlocChanged(
    SystemBloc bloc,
    Change<SystemState> change,
  ) {}
}
