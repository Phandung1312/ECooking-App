import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle withHeight(double? height) => copyWith(height: height);

  TextStyle withColor(Color? color) => copyWith(color: color);

  TextStyle withSize(double? size) => copyWith(fontSize: size);

  TextStyle withWeight(FontWeight? weight) => copyWith(fontWeight: weight);
}
