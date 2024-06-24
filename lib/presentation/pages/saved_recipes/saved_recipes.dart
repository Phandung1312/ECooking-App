import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_bloc.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_event.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/saved_recipes_selector.dart';
import 'package:uq_system_app/presentation/pages/saved_recipes/widgets/draft_recipe.item.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../navigation/navigation.dart';

@RoutePage()
class SavedRecipesPage extends StatefulWidget {
  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  final SavedRecipesBloc _bloc = getIt.get<SavedRecipesBloc>();

  @override
  void initState() {
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
      child: SmartRefresher(
        physics: const ClampingScrollPhysics(),
        controller: _bloc.refreshController,
        onRefresh: () {
          _bloc.add(const SavedRecipesLoadDraftRecipes());
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
              current.status == AuthStatus.success,
              listener: (context, state) {
                _bloc.add(const SavedRecipesLoadDraftRecipes());
              },
            )
          ],
          child: Scaffold(
            backgroundColor: context.colors.secondaryBackground,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.background,
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.hint.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      AssetGenImage(Assets.images.imgRecipe.path).image(
                          width: 100,
                          height: 100,
                          color: context.colors.primary.withOpacity(0.7)),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                            'Lưu giữ những bí quyết nấu ăn của bạn cùng 1 nơi',
                            textAlign: TextAlign.center,
                            style: context.typographies.title2.withColor(
                                context.colors.primary.withOpacity(0.7))),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          var result = await context.router
                              .push(CreateRecipeRoute(recipeId: null));
                          if (result != null) {
                            _bloc.add(const SavedRecipesLoadDraftRecipes());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          backgroundColor:
                              context.colors.secondary.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // maximumSize: Size(100, 50),
                        ),
                        child: Text(
                          'Viết món mới',
                          style: context.typographies.bodyBold
                              .withColor(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SavedRecipesSelector(
                        builder: (data) => data.isEmpty
                            ? Center(
                                child: Text(
                                'Bạn chưa có món nháp nào',
                                style: context.typographies.title3,
                              ))
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${data.length} món nháp',
                                      style: context.typographies.title2
                                          .withColor(context.colors.primary
                                              .withOpacity(0.5))),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.separated(
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          DraftRecipeItem(recipe: data[index], onTap: (bool isUpdated) {
                                            if (isUpdated) {
                                              _bloc.add(const SavedRecipesLoadDraftRecipes());
                                            }
                                          },),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                        selector: (state) => state.draftRecipes),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
