import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/widgets/icon_item.dart';

import '../../../assets.gen.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        SearchRoute(),
        CreateRecipeRoute(),
        NotificationRoute(),
        ProfileRoute()
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        selectedItemColor: context.colors.secondary,

        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          BottomNavigationBarItem(
              activeIcon: IconItem(path: Assets.icons.png.icHomeSelected.path),
              icon: IconItem(path: Assets.icons.png.icHome.path),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: IconItem(path: Assets.icons.png.icSearchSelected.path),
              icon: IconItem(path: Assets.icons.png.icSearch.path),
              label: "Search"),
          BottomNavigationBarItem(
              icon: IconItem(path: Assets.icons.png.icAdd.path),
            label : 'Create'
              ),
          BottomNavigationBarItem(
              activeIcon: IconItem(path: Assets.icons.png.icNotificationSelected.path),
              icon: IconItem(path: Assets.icons.png.icNotification.path),
              label: "Notification"),
          BottomNavigationBarItem(
              activeIcon: IconItem(path: Assets.icons.png.icProfileSelected.path),
              icon: IconItem(path: Assets.icons.png.icProfile.path),
              label: "Profile")
        ],
      ),
    );
  }
}
