import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/search.params.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/widgets/recipe_item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_selector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/account.item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/account.tab.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/instruction.item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/instruction.tab.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/recipe.tab.dart';

import '../search_event.dart';
import '../search_state.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate(
      {super.searchFieldLabel, super.searchFieldStyle, super.textInputAction});

  final SearchBloc _bloc = getIt<SearchBloc>();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      colorScheme: ColorScheme.light(
        background: context.colors.background,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: context.colors.background,
        filled: true,
        border: InputBorder.none,
      ),
      textTheme: theme.textTheme.copyWith(),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      _bloc.add(
          SearchGetResult(params: SearchParams(title: query), isRefresh: true));
    }
    return BlocProvider.value(
      value: _bloc,
      child: SearchSelector(
        selector: (SearchState state) => state.status,
        builder: (data) {
          if (data == SearchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: context.colors.primary, width: 2)),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: context.colors.primary,
                    indicatorWeight: 2,
                    labelStyle: context.typographies.caption1Bold,
                    unselectedLabelStyle: context.typographies.caption1,
                    dividerColor: context.colors.hint.withOpacity(0.5),
                    tabs: const [
                      Tab(
                        text: 'Tất cả',
                      ),
                      Tab(
                        text: 'Công thức',
                      ),
                      Tab(
                        text: 'Công đoạn',
                      ),
                      Tab(
                        text: 'Người dùng',
                      ),
                    ]),
                Expanded(
                    child: Container(
                  color: const Color(0xFFF6F1EC).withOpacity(0.5),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: AutoScaleTabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildAllTap(context),
                        RecipeTab(bloc: _bloc,),
                         InstructionTab(bloc: _bloc,),
                         AccountTab(bloc: _bloc,),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _bloc.add(SearchGetSuggestions(query));
    return BlocProvider.value(
      value: _bloc,
      child: SearchSelector(
        builder: (data) {
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.search),
                title: Text(data[index]),
                onTap: () {
                  query = data[index];
                  showResults(context);
                },
              );
            },
          );
        },
        selector: (SearchState state) => state.suggestions,
      ),
    );
  }

  Widget _buildAllTap(BuildContext context) {
    return SearchSelector(
        selector: (state) => state.searchResult,
        builder: (data) {
          if (data.instructions.isEmpty &&
              data.recipes.isEmpty &&
              data.accounts.isEmpty) {
            return const Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text('Không tìm thấy kết quả phù hợp'),
              ],
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.recipes.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Công thức ',
                            style: context.typographies.title3),
                        if (data.recipes.length > 3) ...[
                          InkWell(
                            onTap: () {},
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
                        ]
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          data.recipes.length > 3 ? 3 : data.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = data.recipes[index];
                        return RecipeItem(
                            recipe: recipe, type: RecipeSearchType.SEARCH);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    )
                  ],
                  if (data.accounts.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Người dùng',
                            style: context.typographies.title3),
                        if (data.accounts.length > 3) ...[
                          InkWell(
                            onTap: () {},
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          data.accounts.length > 3 ? 3 : data.accounts.length,
                      itemBuilder: (context, index) {
                        final account = data.accounts[index];
                        return AccountItem(account: account);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    )
                  ],
                  if (data.instructions.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Công đoạn chế biến',
                            style: context.typographies.title3),
                        if (data.instructions.length > 3) ...[
                          InkWell(
                            onTap: () {},
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.instructions.length > 3
                          ? 3
                          : data.instructions.length,
                      itemBuilder: (context, index) {
                        final instruction = data.instructions[index];
                        return InstructionItem(instruction: instruction);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    )
                  ]
                ],
              ),
            );
          }
        });
  }
}
