import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.errorOccurred([BaseException? error]) =
      HomeErrorOccurred;

  const factory HomeEvent.getDataStarted() = DashboardHomeGetDataStarted;

  const factory HomeEvent.getRefreshData() = HomeRefreshData;
}
