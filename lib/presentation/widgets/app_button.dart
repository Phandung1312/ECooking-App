import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final double? height;
  final String textButton;
  final bool isOutlined;
  final BorderRadiusGeometry borderRadius;
  final Function()? onClick;
  final bool isClickable;
  final int flex;

  const AppButton(
    this.textButton, {
    super.key,
    this.style,
    this.textStyle,
    this.height = 48,
    this.isOutlined = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.onClick,
    this.isClickable = true,
    this.flex = 1,
  });

  const AppButton.outlined(
    this.textButton, {
    this.textStyle,
    this.height = 48,
    this.style,
    this.isOutlined = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.onClick,
    this.isClickable = true,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        width: double.infinity,
        height: style != null ? null : height,
        child: ElevatedButton(
          style: style ??
              context.styles.buttonSmall.copyWith(
                shape: isOutlined && isClickable == true
                    ? MaterialStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(color: context.colors.primary),
                          borderRadius: borderRadius,
                        ),
                      )
                    : context.styles.buttonSmall.shape,
                textStyle: MaterialStatePropertyAll<TextStyle>(
                  textStyle ?? context.typographies.bodyBold,
                ),
                backgroundColor: MaterialStatePropertyAll<Color>(
                  isOutlined && isClickable == true
                      ? context.colors.text
                      : isClickable != true
                          ? context.colors.hint
                          : context.colors.primary,
                ),
              ),
          onPressed: isClickable ? onClick : null,
          child: Text(
            textButton,
            style: context.typographies.bodyBold.copyWith(
              color: isOutlined && isClickable == true
                  ? context.colors.primary
                  : isClickable != true
                      ? context.colors.border
                      : context.colors.text,
            ),
          ),
        ),
      ),
    );
  }
}
