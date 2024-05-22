import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

Future showAlertDialog({
  required BuildContext context,
  String? title,
  required List<String> messages,
  List<Widget>? actions,
  void Function()? onTap,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        actionsPadding: const EdgeInsets.only(top: 5),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: title != null
            ? Text(
                title,
                style: context.typographies.bodyBold,
              )
            : Container(),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView.builder(
            itemCount: messages.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Text(
              messages[index],
              style: context.typographies.body,
            ),
          ),
        ),
        actions: actions ?? [
          TextButton(
            child: Text('Hủy', style: context.typographies.body,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onTap?.call();
            },
            child: Text(
              'OK',
              style: context.typographies.bodyBold
                  .withColor(context.colors.secondary),
            ),
          ),
        ],
      );
    },
  );
}
