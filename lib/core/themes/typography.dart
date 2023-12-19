import 'package:flutter/material.dart';

class AppTypography {
  final TextStyle title1;
  final TextStyle title1SemiBold;
  final TextStyle title1Normal;
  final TextStyle title2;
  final TextStyle title2Bold;
  final TextStyle title3;
  final TextStyle title3Bold;
  final TextStyle body;
  final TextStyle bodyBold;
  final TextStyle caption1;
  final TextStyle caption1Bold;
  final TextStyle caption2;
  final TextStyle caption2Bold;

  const AppTypography({
    required this.title1,
    required this.title1SemiBold,
    required this.title1Normal,
    required this.title2,
    required this.title2Bold,
    required this.title3,
    required this.title3Bold,
    required this.body,
    required this.bodyBold,
    required this.caption1,
    required this.caption1Bold,
    required this.caption2,
    required this.caption2Bold,
  });

  AppTypography lerp(covariant dynamic other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title1SemiBold: TextStyle.lerp(title1SemiBold, other.title1SemiBold, t)!,
      title1Normal: TextStyle.lerp(title1Normal, other.title1Normal, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      title2Bold: TextStyle.lerp(title2Bold, other.title2Bold, t)!,
      title3: TextStyle.lerp(title3, other.title3, t)!,
      title3Bold: TextStyle.lerp(title3Bold, other.title3Bold, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodyBold: TextStyle.lerp(bodyBold, other.bodyBold, t)!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption1Bold: TextStyle.lerp(caption1Bold, other.caption1Bold, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
      caption2Bold: TextStyle.lerp(caption2Bold, other.caption2Bold, t)!,
    );
  }
}
