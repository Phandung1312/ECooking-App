


import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/exceptions/exception.dart';
part 'dashboard_event.freezed.dart';
@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.errorOccurred([BaseException? error]) = DashboardErrorOccurred;
  const factory DashboardEvent.loadUnreadNotifications() = DashboardLoadUnreadNotifications;
}