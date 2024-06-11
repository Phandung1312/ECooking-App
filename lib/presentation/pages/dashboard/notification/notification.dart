import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/blocs/socket/socket.cubit.dart';
import 'package:uq_system_app/presentation/blocs/socket/socket.state.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/notification/notification_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/notification/widgets/notification.item.dart';

import 'notification_bloc.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationBloc _bloc = getIt.get<NotificationBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(const NotificationLoad(isLoadMore: false));
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SocketCubit, SocketState>(
            listener: (context, state) {
              if (state.status == SocketStatus.receivedNewNotification) {
                _bloc.add(NotificationGetNew(id: state.newNotificationId));
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              'Thông báo',
              style: context.typographies.title2,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: context.colors.primary.withOpacity(0.8),
                  size: 25,
                ),
                onPressed: () {
                  context.router.push(const NotificationSettingsRoute());
                },
              ),
            ],
          ),
          body: SmartRefresher(
            controller: _bloc.refreshController,
            physics: const ClampingScrollPhysics(),
            onLoading: () {
              _bloc.add(const NotificationLoad(isLoadMore: true));
            },
            onRefresh: () {
              _bloc.add(const NotificationLoad(isLoadMore: false));
            },
            enablePullUp: true,
            child: NotificationSelector(
              builder: (data) {
                if(data.isNotEmpty){
                  return ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        notification: data[index],
                        onAvatarTap: (id) {
                          _bloc.add(NotificationMarkAsRead(id: data[index].id));
                          context.router.push(UserProfileRoute(userId: id));
                        },
                        onContentTap: (id) {
                          _bloc.add(NotificationMarkAsRead(id: data[index].id));
                          context.router.push(RecipeDetailsRoute(id: id));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    'Thông báo của bạn sẽ xuất hiện ở đây',
                    style: context.typographies.title3.withColor(context.colors.primary.withOpacity(0.5)),
                  ),
                );
              },
              selector: (state) => state.notifications,
            ),
          ),
        ),
      ),
    );
  }
}
