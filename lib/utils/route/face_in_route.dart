import 'package:auto_route/auto_route.dart';

class FadeInRoute extends CustomRoute {
  FadeInRoute({
    required super.page,
    super.fullscreenDialog,
    super.maintainState,
    super.fullMatch = false,
    super.guards,
    super.usesPathAsKey = false,
    super.children,
    super.meta = const {},
    super.title,
    super.path,
    super.keepHistory,
    super.initial,
    super.customRouteBuilder,
    super.durationInMilliseconds,
    super.reverseDurationInMilliseconds,
    super.opaque = true,
    super.barrierDismissible = true,
    super.barrierLabel,
    super.restorationId,
    super.barrierColor,
  }) : super(transitionsBuilder: TransitionsBuilders.fadeIn);
}
