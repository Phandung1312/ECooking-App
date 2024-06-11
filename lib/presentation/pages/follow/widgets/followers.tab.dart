import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_selector.dart';
import 'package:uq_system_app/presentation/pages/follow/widgets/member.item.dart';
import '../../../../domain/entities/account.dart';
import '../follow_bloc.dart';
import '../follow_event.dart';

class FollowersTab extends StatefulWidget {
  final FollowBloc bloc;
  final Account? account;
  const FollowersTab({Key? key, this.account, required this.bloc}) : super(key: key);

  @override
  State<FollowersTab> createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
  @override
  void initState() {
    widget.bloc.followersController = RefreshController(initialRefresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SmartRefresher(
          controller: widget.bloc.followersController,
          physics: const ClampingScrollPhysics(),
          enablePullUp: true,
          onRefresh: () {
            widget.bloc.add(const FollowLoadFollowers(isLoadMore: false));
          },
          onLoading: () {
            widget.bloc.add(const FollowLoadFollowers(isLoadMore: true));
          },
          child: FollowSelector(
            selector: (state) => state.followers,
            builder: (data) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text('Chưa có người theo dõi nào',
                        style: context.typographies.title3),
                  ],
                );
              }
              return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MemberItem(
                    member: data[index],
                    onFollow: (bool isFollow) {
                      widget.bloc.add(FollowEvent.updateFollow(
                          params: FollowParams(
                              followedId: data[index].id,
                              status: isFollow
                                  ? FeatureStatus.enable
                                  : FeatureStatus.disable),
                          type: FollowType.follower));
                    },
                    isMe: widget.account?.id == data[index].id,
                  );
                },
              );
            },
          )),
    );
  }
}
