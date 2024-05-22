import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/helpers/template.helper.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/custom_search_delegate.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/ingredient.item.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final SearchBloc _bloc = getIt.get<SearchBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  void _showSearch(String initialQuery) {
    final delegate = CustomSearchDelegate(
      searchFieldLabel: 'Gõ từ khóa tìm kiếm...',
      searchFieldStyle: context.typographies.body.copyWith(
        color: context.colors.primary,
        fontSize: 18,
      ),
      textInputAction: TextInputAction.search,
    );

    delegate.query = initialQuery;

    showSearch(
      context: context,
      query: initialQuery,
      delegate: delegate,
    );

    if (initialQuery.isNotEmpty) {
      delegate.showResults(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: 80,
              floating: true,
              pinned: true,
              shadowColor: context.colors.hint.withOpacity(0.6),
              elevation: 2,
              forceElevated: true,
              snap: true,
              actions: [
                Theme(
                  data: Theme.of(context).copyWith(
                      appBarTheme: AppBarTheme(
                    color: context.colors.background,
                  )),
                  child: InkWell(
                    onTap: () {
                      _showSearch('');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: context.colors.hint.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: context.colors.primary.withOpacity(0.5),
                            size: 30,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Gõ từ khóa tìm kiếm...',
                              style: context.typographies.body.copyWith(
                                color: context.colors.primary.withOpacity(0.5),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            _buildIngredients()
          ],
        ),
      ),
    );
  }

  Widget _buildIngredients() {
    var ingredientTemplates = TemplateHelper.getIngredientTemplates();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Nguyên liệu phổ biến',
              style: context.typographies.title2
                  .withColor(context.colors.primary.withOpacity(0.8)),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ingredientTemplates.length,
              itemBuilder: (context, index) => IngredientItem(
                  onTap: (value) {
                    _showSearch(value);
                  },
                  ingredientTemplate: ingredientTemplates[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.6,
                  crossAxisCount: 2),
            )
          ],
        ),
      ),
    );
  }
}
