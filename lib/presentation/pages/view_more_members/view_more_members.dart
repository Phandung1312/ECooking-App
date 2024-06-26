import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_event.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_selector.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_state.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/widgets/member.item.dart';

@RoutePage()
class ViewMoreMembersPage extends StatefulWidget {
  @override
  State<ViewMoreMembersPage> createState() => _ViewMoreMembersPageState();
}

class _ViewMoreMembersPageState extends State<ViewMoreMembersPage> {
  final ViewMoreMembersBloc _bloc = getIt.get<ViewMoreMembersBloc>();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onRefresh() async {
    _bloc.add(const ViewMoreMembersLoad(isLoadMore: false));
  }

  void _onLoading() async {
    _bloc.add(const ViewMoreMembersLoad(isLoadMore: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: context.colors.secondaryBackground,
        appBar: AppBar(
            elevation: 1,
            shadowColor: context.colors.hint.withOpacity(0.5),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Top thành viên',
                style: context.typographies.body
                    .copyWith(color: context.colors.primary, fontSize: 20)),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: context.colors.secondary,
              onPressed: () {
                context.router.pop();
              },
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: SmartRefresher(
                  controller: _bloc.refreshController,
                  enablePullUp: true,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ViewMoreMembersBuilder(
                    statuses: ViewMoreMembersStatus.values,
                    builder:
                        (BuildContext context, ViewMoreMembersState state) {
                      return GridView.builder(
                          primary: true,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.members.length,
                          itemBuilder: (context, index) => MemberItem(
                                member: state.members[index],
                                onFollow: () {
                                  _bloc.add(ViewMoreMembersChangeFollow(
                                      FollowParams(
                                          followedId: state.members[index].id,
                                          status:
                                              state.members[index].isFollowing
                                                  ? FeatureStatus.disable
                                                  : FeatureStatus.enable)));
                                },
                              ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.60,
                                  crossAxisCount: 2));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
