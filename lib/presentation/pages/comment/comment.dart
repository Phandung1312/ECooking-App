import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_event.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_selector.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_state.dart';
import 'package:uq_system_app/presentation/pages/comment/widgets/comment_item.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';

@RoutePage()
class CommentPage extends StatefulWidget {
  final int recipeId;

  const CommentPage(this.recipeId);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentBloc _bloc = getIt.get<CommentBloc>();

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  void _onRefresh() async {
    _bloc.add(CommentLoad(recipeId: widget.recipeId, isLoadMore: false));
  }

  void _onLoading() async {
    _bloc.add(CommentLoad(recipeId: widget.recipeId, isLoadMore: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text('Bình luận',
                style: context.typographies.body
                    .copyWith(color: context.colors.primary, fontSize: 20)),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: context.colors.secondary,
              onPressed: () {
                context.router.pop();
              },
            )),
        body: Column(
          children: [
            const DividerLine(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SmartRefresher(
                  physics: const ClampingScrollPhysics(),
              enablePullUp: true,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              controller: _bloc.refreshController,
              child: CommentBuilder(
                statuses: const [CommentStatus.success],
                builder: (BuildContext context, CommentState state) {
                  return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                    itemCount: state.comments.length,
                      itemBuilder: (context, index) =>
                          CommentItem(comment: state.comments[index]));
                },
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.colors.hint,
                    radius: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        style: context.typographies.body
                            .withColor(context.colors.primary),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            color: context.colors.secondary,
                            onPressed: () {},
                          ),
                          hintText: 'Thêm bình luận...',

                          fillColor: context.colors.hint.withOpacity(0.2),
                          isCollapsed: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20), // Bo góc cho trạng thái không focus
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20), // Bo góc cho trạng thái focus
                            borderSide: BorderSide.none, // Loại bỏ viền cho trạng thái focus
                          ),
                          // border: InputBorder.none,
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
