import 'package:easy_localization/easy_localization.dart';
import 'package:uq_system_app/env.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/core/languages/translation_keys.g.dart';
import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  final String username;
  final String urlAvatar;

  const HeaderItem({
    super.key,
    required this.username,
    required this.urlAvatar,
  });

  Widget _buildInformation(
    BuildContext context, {
    required String userName,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            tr(LocaleKeys.Header_HelloUsername, namedArgs: {
              "username": userName,
            }),
            style: context.typographies.caption2,
          ),
          const SizedBox(height: 4),
          Text(
              tr(LocaleKeys.Header_WelcomeToApp, namedArgs: {
                "appName": AppEnv.appName,
              }),
              style: context.typographies.title3),
        ],
      ),
    );
  }

  Widget _buildAvatar({
    required String url,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(50)),
    double size = 40,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        fit: fit,
        width: size,
        height: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildInformation(context, userName: username),
        _buildAvatar(url: urlAvatar),
      ],
    );
  }
}
