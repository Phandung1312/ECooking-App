import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
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
        onTap: (index) async {
          if (index == 2) {
            var userInfoHelper = getIt.get<UserInfoHelper>();
            var isLogged = await userInfoHelper.isUserLogged();
            if (isLogged) {
              if (mounted) {
                context.router.push(const CreateRecipeRoute());
              }
            } else {
              if (mounted) {
                await context.router.push(const LoginRoute()).then((value) {
                  if (value != null && value is bool && value) {
                    context.router.push(const CreateRecipeRoute());
                  }
                });
              }
            }
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
        items: [
          BottomNavigationBarItem(
              activeIcon: IconItem(path: Assets.icons.png.icHomeSelected.path),
              icon: IconItem(path: Assets.icons.png.icHome.path),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon:
                  IconItem(path: Assets.icons.png.icSearchSelected.path),
              icon: IconItem(path: Assets.icons.png.icSearch.path),
              label: "Search"),
          BottomNavigationBarItem(
              icon: IconItem(path: Assets.icons.png.icAdd.path),
              label: 'Create'),
          BottomNavigationBarItem(
              activeIcon:
                  IconItem(path: Assets.icons.png.icNotificationSelected.path),
              icon: IconItem(path: Assets.icons.png.icNotification.path),
              label: "Notification"),
          BottomNavigationBarItem(
              activeIcon:
                  IconItem(path: Assets.icons.png.icProfileSelected.path),
              icon: IconItem(path: Assets.icons.png.icProfile.path),
              label: "Profile")
        ],
      ),
    );
  }
}
