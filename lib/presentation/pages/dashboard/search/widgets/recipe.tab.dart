import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/search.params.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/widgets/recipe_item.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_selector.dart';

import '../search_event.dart';

class RecipeTab extends StatefulWidget {
  final SearchBloc bloc;

  const RecipeTab({super.key, required this.bloc});
  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

class _RecipeTabState extends State<RecipeTab> {
  @override
  void initState() {
    super.initState();
    widget.bloc.recipeController = RefreshController();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void _onLoad() async {
    widget.bloc.add(SearchGetResult(
      params: SearchParams(
        type: SearchType.recipe,
        title: widget.bloc.state.currentQuery,
        page: widget.bloc.state.currentRecipePage,
      ),
      isRefresh: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SmartRefresher(
        physics: const ClampingScrollPhysics(),
        onLoading: _onLoad,
        enablePullDown: false,
        enablePullUp: true,
        controller: widget.bloc.recipeController,
        child: SearchSelector(
          selector: (state) => state.searchResult.recipes,
          builder: (data) {
            if(data.isEmpty){
              return const Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text('Không tìm thấy kết quả phù hợp'),
                ],
              );
            }
            else{
              return ListView.separated(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) => RecipeItem(
                    recipe: data[index], type: RecipeSearchType.SEARCH),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              );
            }
          },
        ),
      ),
    );
  }

}
