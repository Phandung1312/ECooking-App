import 'dart:async';

import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/data/usecases/logout.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Logout _logout;

  AuthBloc(
    this._logout,
  ) : super(const AuthState()) {
    on<AuthLoggedOut>(_onLoggedOut);
  }

  Future<void> _onLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(signOutStatus: AuthSignOutStatus.loading));

      await _logout();

      emit(state.copyWith(
        account: null,
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
