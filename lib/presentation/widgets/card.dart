import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onPressed;

  const AppCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(16),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // boxShadow: boxShadow ?? context.styles.shadow,
          ),
      child: Material(
        borderRadius: borderRadius,
        color: backgroundColor ?? context.colors.background,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
