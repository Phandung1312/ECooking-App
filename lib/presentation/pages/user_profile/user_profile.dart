import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/string.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_event.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_selector.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_state.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/entities/enum/enum.dart';
import '../../../domain/entities/member_details.dart';
import '../../../domain/entities/params/follow.params.dart';
import '../../../helpers/user_info.helper.dart';
import '../../widgets/divider_line.dart';
import '../dashboard/home/widgets/recipe_item.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final int userId;

  const UserProfilePage({required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  final UserProfileBloc _bloc = getIt.get<UserProfileBloc>();
  Account? userAccount;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bloc.refreshController = RefreshController();
    scheduleMicrotask(() async {
      userAccount = await getIt.get<UserInfoHelper>().getAccountUser();
      _bloc.add(UserProfileEvent.loadUserRecipes(
          userId: widget.userId, isLoadMore: false));
      _bloc.add(UserProfileEvent.loadProfile(widget.userId));
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: context.colors.primary,
            onPressed: () {
              context.router.pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: context.colors.primary,
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            _buildProfile(),
            const SizedBox(
              height: 10,
            ),
            _buildStatistical(),
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
                    text: "Công thức",
                  ),
                  Tab(
                    text: "Thông tin",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            UserProfileBuilder(
              builder: (BuildContext context, UserProfileState state) {
                return Expanded(
                  child: AnimatedBuilder(
                    animation: _tabController.animation!,
                    builder: (context, child) {
                      if (_tabController.index == 0) {
                        return SmartRefresher(
                          physics: const ClampingScrollPhysics(),
                            enablePullUp: true,
                            enablePullDown: false,
                            onLoading: () {
                              _bloc.add(UserProfileEvent.loadUserRecipes(
                                  userId: widget.userId, isLoadMore: true));
                            },
                            controller: _bloc.refreshController,
                            child: _buildRecipesTab());
                      } else {
                        return _buildInfoTab(state.profile);
                      }
                    },
                  ),
                );
              },
              statuses: UserProfileStatus.values,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return UserProfileSelector(
      builder: (profile) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
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
                            style: context.typographies.body.withColor(
                                context.colors.text.withOpacity(0.5))),
                      ],
                    ),
                  ),
                  if (userAccount?.id != profile.id)
                    InkWell(
                        onTap: () {
                          if (userAccount != null) {
                            _bloc.add(UserProfileEvent.changeFollow(
                                FollowParams(
                                    followedId: profile.id,
                                    status: profile.isFollowing
                                        ? FeatureStatus.disable
                                        : FeatureStatus.enable)));
                          } else {
                            context.router.push(const LoginRoute());
                          }
                        },
                        child: !profile.isFollowing
                            ? Container(
                                decoration: BoxDecoration(
                                  color: context.colors.secondary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text("Theo dõi",
                                    style: context.typographies.body
                                        .copyWith(color: Colors.white)),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: context.colors.hint.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text("Đang theo dõi",
                                    style: context.typographies.bodyBold),
                              ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
      selector: (UserProfileState state) => state.profile,
    );
  }

  Widget _buildStatistical() {
    return UserProfileSelector(
      builder: (profile) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                    onTap: () {
                      context.router.push(FollowRoute(
                          userId: profile.id,
                          displayName: profile.displayName,
                          isViewFollowers: false));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            profile.followingCount.formatNumber(),
                            style: context.typographies.title2,
                          ),
                          Text(
                            "Đang follow",
                            style: context.typographies.body.withColor(
                                context.colors.text.withOpacity(0.5)),
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
                    onTap: () {
                      context.router.push(FollowRoute(
                          userId: profile.id,
                          displayName: profile.displayName,
                          isViewFollowers: true));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            profile.followerCount.formatNumber(),
                            style: context.typographies.title2,
                          ),
                          Text(
                            "Follower",
                            style: context.typographies.body.withColor(
                                context.colors.text.withOpacity(0.5)),
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
      },
      selector: (UserProfileState state) => state.profile,
    );
  }

  Widget _buildRecipesTab() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: UserProfileSelector(
        selector: (state) => state.recipes,
        builder: (data) {
          if (data.isEmpty) {
            return const Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text('Không tìm thấy kết quả phù hợp'),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => RecipeItem(
                recipe: data[index],
                type: RecipeSearchType.PROFILE,
                onSavedChange: (request) {
                  _bloc.add(UserProfileEvent.changeSavedRecipe(request: request));
                },
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTab(MemberDetails member) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(member.story.isNotEmpty) ... [
              const SizedBox(
                height: 20,
              ),
              Text("Tiểu sử", style: context.typographies.title3Bold),
              const SizedBox(
                height: 10,
              ),
              Text(member.story, style: context.typographies.body),
              const SizedBox(
                height: 10,
              ),
              const DividerLine(),
              const SizedBox(
                height: 10,
              ),
            ],
            Text("Thông tin thêm", style: context.typographies.title3Bold),
            const SizedBox(
              height: 10,
            ),
            if(member.address.isNotEmpty) ...[
              Row(
                children: [
                  AssetGenImage(Assets.icons.png.icLocation.path).image(
                    width: 30,
                    height: 30,
                    color: context.colors.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(member.address, style: context.typographies.body),
                ],
                ),

              const SizedBox(
                height: 10,
              ),
            ],
            Row(
              children: [
                AssetGenImage(Assets.icons.png.icInfo.path).image(
                  width: 30,
                  height: 30,
                  color: context.colors.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("Tham gia vào ${member.createdAt.formatDate()}", style: context.typographies.body),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AssetGenImage(Assets.icons.png.icChart.path).image(
                  width: 30,
                  height: 30,
                  color: context.colors.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("${member.totalViews.formatCurrency()} lượt xem", style: context.typographies.body),
              ],
            ),

      
          ],
        ),
      ),
    );
  }
}
