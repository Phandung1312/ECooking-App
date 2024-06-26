import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/responses/base_error_response.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/usecase/login.usecase.dart';
import 'package:uq_system_app/domain/usecase/logout.usecase.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_event.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUseCase _logoutUseCase;
  final LoginUseCase _loginUseCase;

  AuthBloc( this._logoutUseCase, this._loginUseCase) : super(const AuthState()) {
    on<AuthLogin>(_onLogin);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthErrorOccurred>(_onErrorOccurred);
    on<AuthSessionExpired>(_onSessionExpired);
  }
  FutureOr<void> _onSessionExpired(
    AuthSessionExpired event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    emit(state.copyWith(
      status: AuthStatus.sessionExpired,
    ));
  }
  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try{
      emit(state.copyWith(
        status: AuthStatus.loading,
      ));
      EasyLoading.show();
      await _loginUseCase(event.loginType);
      EasyLoading.dismiss();

      emit(
        state.copyWith(
          status: AuthStatus.success,
        ),
      );
    }catch(exception){
      EasyLoading.dismiss();
      if(exception is DioException){
        var errorResponse = BaseErrorResponse.fromJson(exception.response?.data);
        if(errorResponse.statusCode == 403){
          emit(state.copyWith(
            status: AuthStatus.blocked,
          ));
        }
        else{
          emit(state.copyWith(
            status: AuthStatus.failure,
          ));
        }
      }

    }
  }

  Future<void> _onLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {

    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    EasyLoading.show();
    await _logoutUseCase();
    EasyLoading.dismiss();
    emit(state.copyWith(
      status: AuthStatus.loggedOut,
    ));
  }

  FutureOr<void> _onErrorOccurred(
    AuthErrorOccurred event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      status: AuthStatus.failure,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    add(AuthErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }
}
