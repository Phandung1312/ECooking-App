import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/widgets/saved_recipe.tab.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/widgets/user_recipe.tab.dart';

import '../../../widgets/divider_line.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  final bool isFromDashboard;
  const ProfilePage({this.isFromDashboard = true});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final ProfileBloc _bloc = getIt.get<ProfileBloc>();
  Account? _account;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    scheduleMicrotask(() async {
      _account = await getIt.get<UserInfoHelper>().getAccountUser();
      _bloc.add(ProfileEvent.updateUserId(userId: _account!.id));
      _bloc.add(const ProfileLoadProfile());
    });
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
      child: ProfileSelector(
        selector: (state) => state.profile,
        builder: (data) => Scaffold(
          appBar: AppBar(
            leading: !widget.isFromDashboard
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: context.colors.primary,
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                  )
                : null,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: context.colors.primary,
                ),
                onPressed: () {
                  context.router.push(const SettingsRoute());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: context.colors.primary,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              _buildProfile(data),
              _buildStatistical(data),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                  controller: _tabController,
                  labelColor: context.colors.secondary,
                  unselectedLabelColor: context.colors.hint,
                  labelStyle: context.typographies.bodyBold,
                  unselectedLabelStyle: context.typographies.bodyBold,
                  dividerColor: context.colors.hint.withOpacity(0.5),
                  indicatorColor: context.colors.secondary,
                  tabs: const [
                    Tab(
                      text: "Món đã lưu",
                    ),
                    Tab(
                      text: "Món của tôi",
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: AnimatedBuilder(
                animation: _tabController,
                builder: (BuildContext context, Widget? child) {
                  if (_tabController.index == 0) {
                    return SavedRecipeTab(bloc: _bloc,);
                  }
                  else{
                    return UserRecipeTab(bloc: _bloc);
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(MemberDetails profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final result = await context.router.push(EditProfileRoute(profile: profile));
              if(result != null){
                _bloc.add(const ProfileEvent.loadProfile());
              }
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: profile.avatarUrl.isNotEmpty
                      ? NetworkImage(profile.avatarUrl)
                      : null,
                  backgroundColor: context.colors.hint,
                  radius: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.displayName,
                          style: context.typographies.bodyBold),
                      Text("@${profile.username}",
                          style: context.typographies.body
                              .withColor(context.colors.text.withOpacity(0.5))),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.colors.secondary),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("Chỉnh sửa",
                      style: context.typographies.bodyBold
                          .withColor(context.colors.secondary)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildStatistical(MemberDetails profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          const DividerLine(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      profile.recipeCount.formatNumber(),
                      style: context.typographies.title2,
                    ),
                    Text(
                      "Công thức",
                      style: context.typographies.body
                          .withColor(context.colors.text.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: context.colors.hint.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
              InkWell(
                onTap: (){
                  context.router.push(FollowRoute(userId: profile.id, displayName: profile.displayName, isViewFollowers: false));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        profile.followingCount.formatNumber(),
                        style: context.typographies.title2,
                      ),
                      Text(
                        "Đang follow",
                        style: context.typographies.body
                            .withColor(context.colors.text.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: context.colors.hint.withOpacity(0.5),
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: (){
                  context.router.push(FollowRoute(userId: profile.id, displayName: profile.displayName, isViewFollowers: true));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        profile.followerCount.formatNumber(),
                        style: context.typographies.title2,
                      ),
                      Text(
                        "Follower",
                        style: context.typographies.body
                            .withColor(context.colors.text.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const DividerLine(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
