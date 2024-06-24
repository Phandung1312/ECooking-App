import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_event.dart';
import 'package:uq_system_app/presentation/pages/notification_settings/notification_settings_state.dart';
import '../../../core/exceptions/exception.dart';
@injectable
class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc() : super(const NotificationSettingsState()) {
    on<NotificationSettingsErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(NotificationSettingsErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    NotificationSettingsErrorOccurred event,
    Emitter<NotificationSettingsState> emit,
  ) {
    emit(state.copyWith(
      status: NotificationSettingsStatus.failure,
    ));
  }
}
