import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountIsSigningOutSelector
    extends BlocSelector<AuthBloc, AuthState, bool> {
  AccountIsSigningOutSelector(
      {super.key, required Widget Function(bool isSigningOut) builder})
      : super(
          selector: (state) => state.signOutStatus == AuthSignOutStatus.loading,
          builder: (_, isSigningOut) => builder(isSigningOut),
        );
}
