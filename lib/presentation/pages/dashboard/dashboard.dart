import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/languages/translation_keys.g.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import 'widgets/icon_item.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardHomeRoute(),
        DashboardAccountRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: IconItem(
                path: Assets.icons.svg.icDashboardHome.path, isSelected: true),
            icon: IconItem(path: Assets.icons.svg.icDashboardHome.path),
            label: context.tr(LocaleKeys.Dashboard_Home),
          ),
          BottomNavigationBarItem(
            activeIcon: IconItem(
                path: Assets.icons.svg.icDashboardAccount.path,
                isSelected: true),
            icon: IconItem(path: Assets.icons.svg.icDashboardAccount.path),
            label: context.tr(LocaleKeys.Dashboard_Account),
          ),
        ],
      ),
    );
  }
}
