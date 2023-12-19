import 'package:uq_system_app/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_event.freezed.dart';

@freezed
class SystemEvent with _$SystemEvent {
  const factory SystemEvent.themeChanged(AppTheme theme) = SystemThemeChanged;

  const factory SystemEvent.languageChanged(Locale locale) =
      SystemLanguageChanged;
}
