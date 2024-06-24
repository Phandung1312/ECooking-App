import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_bloc.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_event.dart';
import 'package:uq_system_app/presentation/pages/follow/widgets/followers.tab.dart';
import 'package:uq_system_app/presentation/pages/follow/widgets/followings.tab.dart';

import '../../../helpers/user_info.helper.dart';

@RoutePage()
class FollowPage extends StatefulWidget {
  final int userId;
  final String displayName;
  final bool isViewFollowers;

  const FollowPage(
      {required this.userId,
      required this.displayName,
      required this.isViewFollowers});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FollowBloc _bloc = getIt.get<FollowBloc>();
  Account? _account;

  @override
  void initState() {
     getIt.get<UserInfoHelper>().getAccountUser().then((value) {
      _account = value;
      _bloc.add(FollowUpdateUserId(userId: widget.userId));
      if (widget.isViewFollowers) {
        _tabController.index = 1;
      }
    });
     _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.displayName),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.colors.primary,
              ),
              onPressed: () {
                context.router.pop();
              },
            )),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: context.colors.secondary,
              unselectedLabelColor: context.colors.hint,
              labelStyle: context.typographies.bodyBold,
              unselectedLabelStyle: context.typographies.bodyBold,
              dividerColor: context.colors.hint.withOpacity(0.5),
              indicatorColor: context.colors.secondary,
              tabs: const [
                Tab(
                  text: 'Đang follow',
                ),
                Tab(
                  text: 'Follower',
                ),
              ],
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, child) {
                  if(_tabController.index == 0) {
                    return  FollowingsTab(bloc: _bloc, account: _account,);
                  } else {
                    return  FollowersTab(bloc: _bloc, account:  _account,);
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
