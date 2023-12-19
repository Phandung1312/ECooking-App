import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<DashboardHomeGetDataStarted>(_onGetDataStated);
    on<HomeErrorOccurred>(_onErrorOccurred);
    on<HomeRefreshData>(_onRefreshData);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(HomeErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    HomeErrorOccurred event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      status: HomeStatus.failure,
      error: event.error,
    ));
  }

  FutureOr<void> _onGetDataStated(
    DashboardHomeGetDataStarted event,
    Emitter<HomeState> emit,
  ) async {}

  FutureOr<void> _onRefreshData(
      HomeRefreshData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.refreshing));
  }
}
