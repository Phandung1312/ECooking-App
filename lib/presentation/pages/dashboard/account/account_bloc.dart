import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountState()) {
    on<AccountErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    AccountErrorOccurred event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(
      status: AccountStatus.failure,
    ));
  }
}
