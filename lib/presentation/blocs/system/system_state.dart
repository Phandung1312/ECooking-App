import 'dart:ui';

import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/core/themes/themes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_state.freezed.dart';

@freezed
class SystemState with _$SystemState {
  const factory SystemState({
    required AppTheme theme,
    required Locale locale,
    BaseException? error,
  }) = _SystemState;
}
