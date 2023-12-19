import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

Future showAppDialog({
  required BuildContext context,
  String? textTitle,
  TextStyle? textTitleStyle,
  TextAlign? textAlignTitle = TextAlign.center,
  TextAlign? textAlignBody = TextAlign.center,
  TextStyle? textBodyStyle,
  String? textBody,
  List<Widget>? actions,
  Function()? onClickLeft,
  Function()? onClickRight,
  bool barrierDismissible = true,
  double maxWidth = 340,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: context.colors.text,
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (textTitle != null) ...[
              Text(
                textTitle,
                textAlign: textAlignTitle,
                style: textTitleStyle ??
                    context.typographies.bodyBold.copyWith(
                      color: context.colors.error,
                    ),
              ),
              const SizedBox(height: 16),
            ],
            if (textBody != null) ...[
              Text(
                textBody,
                textAlign: textAlignBody,
                style: textBodyStyle ??
                    context.typographies.caption1.copyWith(
                      color: context.colors.hint,
                    ),
              ),
              const SizedBox(height: 16),
            ],
            if (actions != null) Row(children: actions)
          ],
        ),
      ),
    ),
  );
}
