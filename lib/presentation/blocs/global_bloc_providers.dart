import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uq_system_app/presentation/blocs/socket/socket.cubit.dart';
import 'package:uq_system_app/presentation/blocs/system/system_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocProviders extends StatelessWidget {
  final Widget child;

  const GlobalBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: getIt.get<AuthBloc>(),
        ),
        BlocProvider<SystemBloc>.value(
          value: getIt.get<SystemBloc>(),
        ),
        BlocProvider<SocketCubit>.value(value: getIt.get<SocketCubit>()),
      ],
      child: child,
    );
  }
}
