import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_event.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_state.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/widgets/member_item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/widgets/member_skeleton.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/widgets/recipe_item.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';
import 'package:uq_system_app/presentation/widgets/recipe_skeleton.dart';

import '../../../../assets.gen.dart';
import 'home_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = getIt.get<HomeBloc>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      _bloc.add(const HomeGetPopularRecipes());
      _bloc.add(const HomeGetTopMembers());
      _bloc.add(const HomeGetNewestRecipes(isLoadMore: false));
    });
  }

  void _onLoading() async {
    _bloc.add(const HomeGetNewestRecipes(isLoadMore: true));
  }

  void _onRefresh() async {
    _bloc.add(const HomeGetPopularRecipes());
    _bloc.add(const HomeGetTopMembers());
    _bloc.add(const HomeGetNewestRecipes(isLoadMore: false));
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
        body: Column(
          children: [
            _buildSearch(),
            const DividerLine(),
            Expanded(
              child: SmartRefresher(
                controller: _bloc.refreshController,
                physics: const ClampingScrollPhysics(),
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                enablePullDown: true,
                enablePullUp: true,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _buildPopularRecipes(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTopMember(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildNewestRecipes(),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colors.secondary, // Viền màu đỏ
                width: 2.0, // Độ dày của viền
              ),
            ),
            child: ClipOval(
              child: AssetGenImage(Assets.images.appLogo.path)
                  .image(width: 32, height: 32, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.router.push(const SearchRoute()).then((_) {
                  context.router
                      .popUntil((route) => route.settings.name == '/');
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.colors.hint.withOpacity(0.2)),
                child: Row(
                  children: [
                    AssetGenImage(Assets.icons.png.icSearch.path)
                        .image(width: 28, fit: BoxFit.cover),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Gõ tên nguyên liệu, công thức...",
                      overflow: TextOverflow.ellipsis,
                      style: context.typographies.body
                          .withColor(context.colors.hint),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Widget _buildPopularRecipes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Công thức phổ biến",
                style: context.typographies.title3
                    .withColor(context.colors.secondary),
              ),
              InkWell(
                onTap: () {
                  context.router.push(const ViewMoreRecipesRoute());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Xem thêm",
                      style: context.typographies.caption2
                          .withColor(context.colors.hint),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.colors.hint,
                      size: 14,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 320,
            child: HomeBuilder(
              builder: (BuildContext context, state) {
                if (state.status == HomeStatus.loadingPopularRecipes) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        const RecipeSkeleton(type: RecipeSearchType.POPULAR),
                  );
                }
                if (state.status == HomeStatus.loadedPopularRecipes) {
                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.popularRecipes.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.popularRecipes.length) {
                        return RecipeItem(
                            recipe: state.popularRecipes[index],
                            type: RecipeSearchType.POPULAR,
                            onSavedChange: (request) {
                              _bloc.add(HomeChangeSavedRecipe(
                                  request: request,
                                  type: RecipeSearchType.POPULAR));
                            });
                      } else {
                        return InkWell(
                          onTap: () {
                            context.router.push(const ViewMoreRecipesRoute());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AssetGenImage(Assets.icons.png.icNext.path)
                                .image(
                              width: 48,
                              height: 48,
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                  );
                }

                return Container();
              },
              statuses: const [
                HomeStatus.loadingPopularRecipes,
                HomeStatus.loadedPopularRecipes,
                HomeStatus.failure
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopMember() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top thành viên",
            style:
                context.typographies.title3.withColor(context.colors.secondary),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: context.colors.hint.withOpacity(0.2), width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HomeBuilder(
                  builder: (context, state) {
                    if (state.status == HomeStatus.loadingTopMembers) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) => const MemberSkeleton(),
                      );
                    }
                    if (state.status == HomeStatus.loadedTopMembers) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.topMembers.length,
                        itemBuilder: (context, index) => MemberItem(
                          member: state.topMembers[index],
                          number: index + 1,
                        ),
                      );
                    }
                    return Container();
                  },
                  statuses: const [
                    HomeStatus.loadingTopMembers,
                    HomeStatus.loadedTopMembers,
                    HomeStatus.failure
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      context.router.push(const ViewMoreMembersRoute());
                    },
                    child: Text(
                      "Xem thêm >>",
                      style: context.typographies.bodyBold
                          .withColor(context.colors.text.withOpacity(0.8)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNewestRecipes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Công thức mới nhất",
            style:
                context.typographies.title3.withColor(context.colors.secondary),
          ),
          const SizedBox(
            height: 10,
          ),
          HomeBuilder(
            statuses: const [
              HomeStatus.loadingNewestRecipes,
              HomeStatus.loadedNewestRecipes,
              HomeStatus.failure
            ],
            builder: (BuildContext context, HomeState state) {
              if (state.status == HomeStatus.loadingNewestRecipes) {
                return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        const RecipeSkeleton(type: RecipeSearchType.NEWEST),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.7,
                            crossAxisCount: 2));
              }
              if (state.status == HomeStatus.loadedNewestRecipes) {
                return GridView.builder(
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.newestRecipes.length,
                    itemBuilder: (context, index) => RecipeItem(
                        recipe: state.newestRecipes[index],
                        type: RecipeSearchType.NEWEST,
                        onSavedChange: (request) {
                          _bloc.add(HomeChangeSavedRecipe(
                              request: request, type: RecipeSearchType.NEWEST));
                        }),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.75,
                            crossAxisCount: 2));
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
