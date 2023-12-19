import 'package:easy_localization/easy_localization.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/core/languages/translation_keys.g.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';
import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  final String name;
  final Function()? onClickTitle;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const TitleItem(
    this.name, {
    super.key,
    required this.onClickTitle,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  Widget _buildTitle(BuildContext context) {
    return Text(
      name,
      style: context.typographies.bodyBold.copyWith(
        color: context.colors.primary,
      ),
    );
  }

  Widget _buildExploreAll(BuildContext context) {
    return InkWell(
      onTap: onClickTitle,
      child: Text(
        tr(LocaleKeys.Title_ExploreAll),
        style: context.typographies.caption1.copyWith(
          color: context.colors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Column(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            _buildTitle(context),
            DividerLine(
              width: name.length.toDouble() * name.length / 2,
            )
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 2),
            _buildExploreAll(context),
          ],
        )
      ],
    );
  }
}
