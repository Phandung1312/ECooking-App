import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.divider,
      height:1,
    );
  }
}

