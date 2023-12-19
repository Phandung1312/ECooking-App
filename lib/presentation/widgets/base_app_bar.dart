import 'package:flutter/material.dart';

class IconOptions {
  final double size;
  final BorderRadiusGeometry borderRadius;
  final Color? color;

  const IconOptions({
    this.size = 24,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  });
}

class CustomAppBar extends AppBar {
  final String appBarTitle;
  final TextAlign titleAlign;
  final EdgeInsetsGeometry? titleMargin;

  final IconOptions iconSettingOptions;
  final IconOptions iconBackOptions;

  final Function()? onSettings;
  final Function()? onBackPress;

  CustomAppBar({
    required this.appBarTitle,
    this.onBackPress,
    this.titleMargin,
    this.onSettings,
    this.iconSettingOptions = const IconOptions(),
    this.iconBackOptions = const IconOptions(),
    this.titleAlign = TextAlign.start,
    super.title,
    super.toolbarHeight,
    super.elevation,
    super.backgroundColor,
    super.titleSpacing = 0,
  });

  @override
  Widget? get title => Container(
        margin: titleMargin ??
            EdgeInsets.only(
              left: onBackPress != null ? 0 : 24,
              right: onSettings != null ? 0 : 24,
              top: 0,
              bottom: 0,
            ),
        width: double.infinity,
        child: Text(
          appBarTitle,
          textAlign: titleAlign,
        ),
      );

  Widget _buildIcon(IconData icon, IconOptions options) {
    return SizedBox(
      width: preferredSize.height,
      height: preferredSize.height,
      child: Icon(
        Icons.settings,
        color: options.color,
        size: options.size,
      ),
    );
  }

  @override
  List<Widget>? get actions => [
        if (onSettings != null)
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: iconSettingOptions.borderRadius,
            ),
            onTap: onSettings,
            child: _buildIcon(Icons.settings, iconSettingOptions),
          ),
      ];

  @override
  Widget? get leading => onBackPress != null
      ? InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: iconBackOptions.borderRadius,
          ),
          onTap: () => onBackPress,
          child: _buildIcon(Icons.keyboard_backspace, iconBackOptions),
        )
      : null;
}
