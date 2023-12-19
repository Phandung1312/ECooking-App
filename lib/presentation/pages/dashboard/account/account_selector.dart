import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_state.dart';

class AccountStatusSelector
    extends BlocSelector<AccountBloc, AccountState, AccountStatus> {
  AccountStatusSelector({
    required Widget Function(AccountStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}

class AccountStatusListener extends BlocListener<AccountBloc, AccountState> {
  AccountStatusListener({
    required Iterable<AccountStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status &&
              statuses.contains(currentState.status),
        );
}
