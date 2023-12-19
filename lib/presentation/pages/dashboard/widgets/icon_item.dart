import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

class IconItem extends StatelessWidget {
  final String path;
  final bool isSelected;
  final double size;

  const IconItem({
    super.key,
    required this.path,
    this.isSelected = false,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        isSelected ? context.colors.primary : context.colors.border,
        BlendMode.srcIn,
      ),
    );
  }
}
