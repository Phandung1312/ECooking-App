import 'dart:async';
import 'package:uq_system_app/core/themes/themes.dart';
import 'package:uq_system_app/data/usecases/save_language.dart';
import 'package:uq_system_app/presentation/blocs/system/system_event.dart';
import 'package:uq_system_app/presentation/blocs/system/system_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  final SaveLanguage _saveLanguage;

  SystemBloc(
    this._saveLanguage, {
    required Locale locale,
  }) : super(SystemState(
          theme: AppTheme.defaultTheme,
          locale: locale,
        )) {
    on<SystemThemeChanged>(_onThemeChanged);
    on<SystemLanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onThemeChanged(
      SystemThemeChanged event, Emitter<SystemState> emit) async {
    emit(state.copyWith(theme: event.theme));
  }

  Future<void> _onLanguageChanged(
      SystemLanguageChanged event, Emitter<SystemState> emit) async {
    await _saveLanguage(event.locale);

    emit(state.copyWith(locale: event.locale));
  }
}
