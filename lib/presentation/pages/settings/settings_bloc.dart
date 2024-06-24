import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/settings/settings_event.dart';
import 'package:uq_system_app/presentation/pages/settings/settings_state.dart';
import '../../../core/exceptions/exception.dart';
@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsErrorOccurred>(_onErrorOccurred);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(SettingsErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    SettingsErrorOccurred event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      status: SettingsStatus.failure,
    ));
  }
}
