import 'package:auto_route/auto_route.dart';

class FullscreenDialogRoute extends MaterialRoute {
  FullscreenDialogRoute({
    required super.page,
    super.path,
    super.maintainState,
    super.fullMatch = false,
    super.guards,
    super.usesPathAsKey = false,
    super.children,
    super.meta = const {},
    super.title,
    super.keepHistory,
    super.restorationId,
    super.initial,
  }) : super(fullscreenDialog: true);
}
