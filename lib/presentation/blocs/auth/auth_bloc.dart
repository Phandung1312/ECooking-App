import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/usecases/logout.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/usecase/login.usecase.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Logout _logout;
  final LoginUseCase _loginUseCase;

  AuthBloc(
    this._logout,
      this._loginUseCase
  ) : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthLoggedOut>(_onLoggedOut);
  }
  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async{
    await _loginUseCase(event.loginType);
  }
  Future<void> _onLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(signOutStatus: AuthSignOutStatus.loading));

      await _logout();

      emit(state.copyWith(
        // account: null,
        error: event.error,
      ));
    } catch (error) {
      emit(state.copyWith(
        error: BaseException.from(error),
        signOutStatus: AuthSignOutStatus.failure,
      ));
    }
  }
}
