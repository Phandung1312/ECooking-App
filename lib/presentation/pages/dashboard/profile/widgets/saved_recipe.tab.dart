import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_selector.dart';

import '../../../../../domain/entities/enum/enum.dart';
import '../../home/widgets/recipe_item.dart';
import '../profile_bloc.dart';
import '../profile_event.dart';

class SavedRecipeTab extends StatefulWidget {
  final ProfileBloc bloc;

  const SavedRecipeTab({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SavedRecipeTab> createState() => _SavedRecipeTabState();
}

class _SavedRecipeTabState extends State<SavedRecipeTab> {
  @override
  void initState() {
    widget.bloc.savedRecipesController = RefreshController();
    widget.bloc.add(const ProfileLoadSavedRecipes(isLoadMore: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.bloc.savedRecipesController,
      physics: const ClampingScrollPhysics(),
      enablePullUp: true,
      onRefresh: () {
        widget.bloc
            .add(const ProfileLoadSavedRecipes(isLoadMore: false));
      },
      onLoading: () {
        widget.bloc
            .add(const ProfileLoadSavedRecipes(isLoadMore: true));
      },
      child: ProfileSelector(
        selector: (state) => state.savedRecipes,
        builder: (data) => data.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text('Công thức đã lưu sẽ hiển thị ở đây',
                      style: context.typographies.title3),
                ],
              )
            : ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => RecipeItem(
                recipe: data[index],
                type: RecipeSearchType.SEARCH,
                onSavedChange: (request){
                  widget.bloc.add(ProfileChangeSavedRecipe(request: request));
                },
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
      ),
    );
  }
}
