

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/presentation/pages/follow/widgets/member.item.dart';

import '../../../../di/injector.dart';
import '../../../../domain/entities/enum/enum.dart';
import '../../../../domain/entities/params/follow.params.dart';
import '../../../../helpers/user_info.helper.dart';
import '../follow_bloc.dart';
import '../follow_event.dart';
import '../follow_selector.dart';

class FollowingsTab extends StatefulWidget {
  final FollowBloc bloc;
  final Account? account;

  const FollowingsTab({Key? key, required this.bloc, this.account}) : super(key: key);

  @override
  State<FollowingsTab> createState() => _FollowingsTabState();
}

class _FollowingsTabState extends State<FollowingsTab> {
  @override
  void initState() {
    widget.bloc.followingsController = RefreshController(initialRefresh: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SmartRefresher(
          controller: widget.bloc.followingsController,
          physics: const ClampingScrollPhysics(),
          enablePullUp: true,
          onRefresh: () {
            widget.bloc.add(const FollowLoadFollowings(isLoadMore: false));
          },
          onLoading: () {
            widget.bloc.add(const FollowLoadFollowings(isLoadMore: true));
          },
          child: FollowSelector(
            selector: (state) => state.followings,
            builder: (data) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text('Tài khoản này chưa theo dõi bất kì ai',
                        style: context.typographies.title3),
                  ],
                );
              }
              return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MemberItem(member: data[index], onFollow: (bool isFollow) {
                    widget.bloc.add(FollowEvent.updateFollow(
                        params: FollowParams(
                            followedId: data[index].id,
                            status: isFollow
                                ? FeatureStatus.enable
                                : FeatureStatus.disable),
                        type: FollowType.following));
                  }, isMe: widget.account?.id == data[index].id,);
                },
              );
            },
          )),
    );
  }
}