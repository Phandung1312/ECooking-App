import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_bloc.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_event.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_selector.dart';
import 'package:uq_system_app/presentation/pages/view_more_recipes/view_more_recipes_state.dart';

import '../../../domain/entities/enum/enum.dart';
import '../../widgets/recipe_skeleton.dart';
import '../dashboard/home/widgets/recipe_item.dart';


@RoutePage()
class ViewMoreRecipesPage extends StatefulWidget {
  @override
  State<ViewMoreRecipesPage> createState() => _ViewMoreRecipesPageState();
}

class _ViewMoreRecipesPageState extends State<ViewMoreRecipesPage> {
  final ViewMoreRecipesBloc _bloc = getIt.get<ViewMoreRecipesBloc>();

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }
  void _onRefresh() async {
    _bloc.add(const ViewMoreRecipesLoad(isLoadMore: false));
  }
  void _onLoading() async {
    _bloc.add(const ViewMoreRecipesLoad(isLoadMore: true));
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: context.colors.backgroundDark,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
                'Công thức phổ biến',
                style: context.typographies.body.copyWith(
                    color: context.colors.primary, fontSize: 20)
            ),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: context.colors.secondary,
              onPressed: () {
                context.router.pop();
              },
            )
        ),
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
                  child: ViewMoreRecipesBuilder(statuses: ViewMoreRecipesStatus.values,
                    builder: (BuildContext context, ViewMoreRecipesState state) {
                      if (state.status == ViewMoreRecipesStatus.loading) {
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
                      if (state.status == ViewMoreRecipesStatus.success) {
                        return GridView.builder(
                            primary: true,
                            shrinkWrap: true,
                            // controller: scrollController,
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.recipes.length,
                            itemBuilder: (context, index) => RecipeItem(
                                recipe: state.recipes[index],
                                type: RecipeSearchType.NEWEST),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.75,
                                crossAxisCount: 2));
                      }
                      return Container();
                    },),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
