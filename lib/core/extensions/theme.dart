import 'package:uq_system_app/core/themes/colors.dart';
import 'package:uq_system_app/core/themes/styles.dart';
import 'package:uq_system_app/core/themes/themes.dart';
import 'package:uq_system_app/core/themes/typography.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on BuildContext {
  AppTheme get appTheme =>
      Theme.of(this).extension<AppTheme>() ?? AppTheme.defaultTheme;

  AppTypography get typographies => appTheme.typographies;

  AppColors get colors => appTheme.colors;

  AppStyles get styles => appTheme.styles;
}
