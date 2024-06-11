import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/helpers/google_auth.helper.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/blocs/socket/socket.cubit.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/widgets/icon_item.dart';

import '../../../assets.gen.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import 'package:badges/badges.dart' as badges;

import '../../blocs/socket/socket.state.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardBloc _bloc = getIt.get<DashboardBloc>();
  final SocketCubit _socketCubit = getIt.get<SocketCubit>();
  Account? _account;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      var userInfoHelper = getIt.get<UserInfoHelper>();
      _account = await userInfoHelper.getAccountUser();
      if (_account != null) {
        _bloc.add(const DashboardLoadUnreadNotifications());
        _socketCubit.connect();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showSessionExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Phiên đăng nhập đã hết hạn',
          style: context.typographies.title3,
        ),
        content: Text(
          'Vui lòng đăng nhập lại để tiếp tục sử dụng tính năng này',
          style: context.typographies.body,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK', style: context.typographies.bodyBold),
            onPressed: () {
              Navigator.of(context).pop();
              context.router.push(const LoginRoute());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                current.status == AuthStatus.sessionExpired ||
                current.status == AuthStatus.success,
            listener: (context, state) async {
              if (state.status == AuthStatus.sessionExpired) {
                await GoogleAuthHelper.signOut();
                if (mounted) {
                  _showSessionExpiredDialog(context);
                }
              } else if (state.status == AuthStatus.success) {
                var userInfoHelper = getIt.get<UserInfoHelper>();
                var account = await userInfoHelper.getAccountUser();
                _bloc.add(const DashboardLoadUnreadNotifications());
                _socketCubit.connect();
                if (mounted) {
                  setState(() {
                    _account = account;
                  });
                }
              }
            },
          ),
          BlocListener<SocketCubit, SocketState>(listener: (context, state) {
            if (state.status == SocketStatus.notificationChanged) {
              _bloc.add(const DashboardLoadUnreadNotifications());
            }
            if (state.status == SocketStatus.receivedNewNotification) {
              _bloc.add(const DashboardLoadUnreadNotifications());
            }
          }),
        ],
        child: AutoTabsScaffold(
          routes: [
            const HomeRoute(),
            const SearchRoute(),
            const SavedRecipesRoute(),
            const NotificationRoute(),
            ProfileRoute()
          ],
          bottomNavigationBuilder: (context, tabsRouter) => DashboardSelector(
              selector: (state) => state.totalUnreadNotification,
              builder: (data) {
                return BottomNavigationBar(
                  selectedItemColor: context.colors.secondary,
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (index) async {
                    if (index == 2 || index == 3 || index == 4) {
                      var userInfoHelper = getIt.get<UserInfoHelper>();
                      var isLogged = await userInfoHelper.isUserLogged();
                      if (isLogged) {
                        tabsRouter.setActiveIndex(index);
                      } else {
                        if (mounted) {
                          await context.router
                              .push(const LoginRoute())
                              .then((value) {
                            if (value != null && value is bool && value) {
                              tabsRouter.setActiveIndex(index);
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
                        activeIcon: IconItem(
                            path: Assets.icons.png.icHomeSelected.path),
                        icon: IconItem(path: Assets.icons.png.icHome.path),
                        label: "Home"),
                    BottomNavigationBarItem(
                        activeIcon: IconItem(
                            path: Assets.icons.png.icSearchSelected.path),
                        icon: IconItem(path: Assets.icons.png.icSearch.path),
                        label: "Search"),
                    BottomNavigationBarItem(
                        icon: IconItem(path: Assets.icons.png.icAdd.path),
                        label: 'Create'),
                    BottomNavigationBarItem(
                        activeIcon: badges.Badge(
                            showBadge: data > 0,
                            badgeContent: Text(
                              data.toString(),
                              style: context.typographies.caption1
                                  .copyWith(color: Colors.white),
                            ),
                            child: IconItem(
                                path: Assets
                                    .icons.png.icNotificationSelected.path)),
                        icon: badges.Badge(
                            showBadge: data > 0,
                            badgeContent: Text(
                              data.toString(),
                              style: context.typographies.caption1
                                  .copyWith(color: Colors.white),
                            ),
                            child: IconItem(
                                path: Assets.icons.png.icNotification.path)),
                        label: "Notification"),
                    BottomNavigationBarItem(
                        activeIcon: IconItem(
                            path: Assets.icons.png.icProfileSelected.path),
                        icon: IconItem(path: Assets.icons.png.icProfile.path),
                        label: "Profile")
                  ],
                );
              }),
        ),
      ),
    );
  }
}
