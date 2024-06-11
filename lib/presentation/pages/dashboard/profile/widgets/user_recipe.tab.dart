import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_selector.dart';

import '../../../../../domain/entities/enum/enum.dart';
import '../../home/widgets/recipe_item.dart';
import '../profile_event.dart';

class UserRecipeTab extends StatefulWidget {
  final ProfileBloc bloc;

  const UserRecipeTab({Key? key, required this.bloc}) : super(key: key);

  @override
  State<UserRecipeTab> createState() => _UserRecipeTabState();
}

class _UserRecipeTabState extends State<UserRecipeTab> {
  @override
  void initState() {
    widget.bloc.userRecipesController = RefreshController();
    widget.bloc.add(const ProfileLoadUserRecipes(isLoadMore: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.bloc.userRecipesController,
      physics: const ClampingScrollPhysics(),
      enablePullUp: true,
      onRefresh: () {
        widget.bloc
            .add(const ProfileLoadUserRecipes(isLoadMore: false));
      },
      onLoading: () {
        widget.bloc.add(const ProfileLoadUserRecipes(isLoadMore: true));
      },
      child: ProfileSelector(
        selector: (state) => state.userRecipes,
        builder: (data) => data.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text('Bạn chưa có công thức nào',
                      style: context.typographies.title3),
                ],
              )
            : ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => RecipeItem(
                recipe: data[index],
                type: RecipeSearchType.MY_RECIPE,
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
      ),
    );
  }
}
