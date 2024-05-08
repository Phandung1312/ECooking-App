/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsAudiosGen {
  const $AssetsAudiosGen();

  /// File path: assets/audios/.gitkeep
  String get gitkeep => 'assets/audios/.gitkeep';

  /// List of all assets
  List<String> get values => [gitkeep];
}

class $AssetsFilesGen {
  const $AssetsFilesGen();

  /// File path: assets/files/.gitkeep
  String get gitkeep => 'assets/files/.gitkeep';

  /// List of all assets
  List<String> get values => [gitkeep];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  $AssetsIconsPngGen get png => const $AssetsIconsPngGen();
  $AssetsIconsSvgGen get svg => const $AssetsIconsSvgGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/.gitkeep
  String get gitkeep => 'assets/images/.gitkeep';

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo => const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/img_login_bg.jpg
  AssetGenImage get imgLoginBg => const AssetGenImage('assets/images/img_login_bg.jpg');

  /// List of all assets
  List<dynamic> get values => [gitkeep, appLogo, imgLoginBg];
}

class $AssetsIconsPngGen {
  const $AssetsIconsPngGen();

  /// File path: assets/icons/png/.gitkeep
  String get gitkeep => 'assets/icons/png/.gitkeep';

  /// File path: assets/icons/png/ic_add.png
  AssetGenImage get icAdd => const AssetGenImage('assets/icons/png/ic_add.png');

  /// File path: assets/icons/png/ic_bookmark.png
  AssetGenImage get icBookmark => const AssetGenImage('assets/icons/png/ic_bookmark.png');

  /// File path: assets/icons/png/ic_bookmarked.png
  AssetGenImage get icBookmarked => const AssetGenImage('assets/icons/png/ic_bookmarked.png');

  /// File path: assets/icons/png/ic_facebook.png
  AssetGenImage get icFacebook => const AssetGenImage('assets/icons/png/ic_facebook.png');

  /// File path: assets/icons/png/ic_favorite.png
  AssetGenImage get icFavorite => const AssetGenImage('assets/icons/png/ic_favorite.png');

  /// File path: assets/icons/png/ic_google.png
  AssetGenImage get icGoogle => const AssetGenImage('assets/icons/png/ic_google.png');

  /// File path: assets/icons/png/ic_hello.png
  AssetGenImage get icHello => const AssetGenImage('assets/icons/png/ic_hello.png');

  /// File path: assets/icons/png/ic_home.png
  AssetGenImage get icHome => const AssetGenImage('assets/icons/png/ic_home.png');

  /// File path: assets/icons/png/ic_home_selected.png
  AssetGenImage get icHomeSelected => const AssetGenImage('assets/icons/png/ic_home_selected.png');

  /// File path: assets/icons/png/ic_next.png
  AssetGenImage get icNext => const AssetGenImage('assets/icons/png/ic_next.png');

  /// File path: assets/icons/png/ic_notification.png
  AssetGenImage get icNotification => const AssetGenImage('assets/icons/png/ic_notification.png');

  /// File path: assets/icons/png/ic_notification_selected.png
  AssetGenImage get icNotificationSelected =>
      const AssetGenImage('assets/icons/png/ic_notification_selected.png');

  /// File path: assets/icons/png/ic_profile.png
  AssetGenImage get icProfile => const AssetGenImage('assets/icons/png/ic_profile.png');

  /// File path: assets/icons/png/ic_profile_selected.png
  AssetGenImage get icProfileSelected =>
      const AssetGenImage('assets/icons/png/ic_profile_selected.png');

  /// File path: assets/icons/png/ic_search.png
  AssetGenImage get icSearch => const AssetGenImage('assets/icons/png/ic_search.png');

  /// File path: assets/icons/png/ic_search_selected.png
  AssetGenImage get icSearchSelected =>
      const AssetGenImage('assets/icons/png/ic_search_selected.png');

  /// File path: assets/icons/png/ic_video.png
  AssetGenImage get icVideo => const AssetGenImage('assets/icons/png/ic_video.png');

  /// File path: assets/icons/png/ic_view.png
  AssetGenImage get icView => const AssetGenImage('assets/icons/png/ic_view.png');

  /// List of all assets
  List<dynamic> get values => [
        gitkeep,
        icAdd,
        icBookmark,
        icBookmarked,
        icFacebook,
        icFavorite,
        icGoogle,
        icHello,
        icHome,
        icHomeSelected,
        icNext,
        icNotification,
        icNotificationSelected,
        icProfile,
        icProfileSelected,
        icSearch,
        icSearchSelected,
        icVideo,
        icView
      ];
}

class $AssetsIconsSvgGen {
  const $AssetsIconsSvgGen();

  /// File path: assets/icons/svg/.gitkeep
  String get gitkeep => 'assets/icons/svg/.gitkeep';

  /// File path: assets/icons/svg/ic_dashboard_account.svg
  SvgGenImage get icDashboardAccount =>
      const SvgGenImage('assets/icons/svg/ic_dashboard_account.svg');

  /// File path: assets/icons/svg/ic_dashboard_home.svg
  SvgGenImage get icDashboardHome => const SvgGenImage('assets/icons/svg/ic_dashboard_home.svg');

  /// File path: assets/icons/svg/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/icons/svg/ic_search.svg');

  /// List of all assets
  List<dynamic> get values => [gitkeep, icDashboardAccount, icDashboardHome, icSearch];
}

class Assets {
  Assets._();

  static const $AssetsAudiosGen audios = $AssetsAudiosGen();
  static const $AssetsFilesGen files = $AssetsFilesGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
