


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/usecase/notification/count_unread_notifications.usecase.dart';

import '../../../core/exceptions/exception.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final CountUnreadNotificationsUseCase _countUnreadNotificationUseCase;

  DashboardBloc(this._countUnreadNotificationUseCase) : super(const DashboardState()){
    on<DashboardErrorOccurred>(_onErrorOccurred);
    on<DashboardLoadUnreadNotifications>(_onCountUnreadNotifications);
  }
  FutureOr<void> _onCountUnreadNotifications(DashboardLoadUnreadNotifications event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(
      status: DashboardStatus.loading,
    ));
    final result  = await _countUnreadNotificationUseCase();
    emit(state.copyWith(
      totalUnreadNotification: result,
      status: DashboardStatus.success,
    ));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    add(DashboardErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
      DashboardErrorOccurred event,
      Emitter<DashboardState> emit,
      ) {
    emit(state.copyWith(
      status: DashboardStatus.failure,
    ));
  }
}