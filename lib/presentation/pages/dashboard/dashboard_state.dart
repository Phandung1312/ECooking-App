

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/exceptions/exception.dart';

part 'dashboard_state.freezed.dart';
enum  DashboardStatus{
  initial,
  loading,
  success,
  failure,
}

@freezed
class DashboardState with _$DashboardState{
  const factory DashboardState({
    @Default(0) totalUnreadNotification,
    @Default(DashboardStatus.initial) DashboardStatus status,
    BaseException? error,
  }) = _DashboardState;
}
