import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_bloc.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_event.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_selector.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_state.dart';
import 'package:uq_system_app/presentation/pages/comment/widgets/comment_item.dart';
import 'package:uq_system_app/presentation/widgets/divider_line.dart';

import '../../../data/models/comment/comment.request.dart';

@RoutePage()
class CommentPage extends StatefulWidget {
  final int recipeId;
  final bool isWriteComment;

  const CommentPage(this.recipeId, this.isWriteComment);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentBloc _bloc = getIt.get<CommentBloc>();
  Account? account;
  late FocusNode _commentFocusNode;
  late TextEditingController _commentController;
  bool isReplying = false;
  int? parentId;
  int? responseId;
  String? responseName;

  @override
  void initState() {
    super.initState();
    _commentFocusNode = FocusNode();
    if (widget.isWriteComment) {
      _commentFocusNode.requestFocus();
    }
    _commentController = TextEditingController();

      scheduleMicrotask(() async {
        account = await getIt.get<UserInfoHelper>().getAccountUser();
        setState(() {
        });
    });
  }

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
                statuses: const [CommentStatus.success, CommentStatus.sending],
                builder: (BuildContext context, CommentState state) {
                  return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) => CommentItem(
                          comment: state.comments[index],
                          onReply: (parentId, responseId, responseName) {
                            setState(() {
                              isReplying = true;
                              this.parentId = parentId;
                              this.responseId = responseId;
                              this.responseName = responseName;
                            });
                            _commentFocusNode.requestFocus();
                          }));
                },
              ),
            )),
            if (isReplying)
              Container(
                decoration: BoxDecoration(
                  color: context.colors.hint.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.hint.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    )
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Text('Trả lời: ',
                        style: context.typographies.body
                            .copyWith(color: context.colors.primary)),
                    Text(responseName ?? '',
                        style: context.typographies.bodyBold
                            .copyWith(color: context.colors.primary)),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isReplying = false;
                          parentId = null;
                          responseId = null;
                          responseName = null;
                        });
                        _commentFocusNode.unfocus();
                        _commentController.clear();
                      },
                      child: Text("Hủy",
                          style: context.typographies.bodyBold.withColor(
                              context.colors.primary.withOpacity(0.5))),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: account?.avatarUrl.isNotEmpty == true
                        ? NetworkImage(account!.avatarUrl)
                        : null,
                    backgroundColor: context.colors.hint,
                    radius: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        focusNode: _commentFocusNode,
                        controller: _commentController,
                        style: context.typographies.body.copyWith(
                            color: context.colors.primary,
                            decorationThickness: 0),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            color: context.colors.secondary,
                            onPressed: () {
                              if (_commentController.text.isNotEmpty) {
                                _bloc.add(CommentCreateComment(
                                    commentRequest: CommentRequest(
                                        content: _commentController.text,
                                        parentId: parentId,
                                        responseId: responseId,
                                        recipeId: widget.recipeId),
                                    userInfo: account!));
                                _commentController.clear();
                                _commentFocusNode.unfocus();
                                setState(() {
                                  isReplying = false;
                                  parentId = null;
                                  responseId = null;
                                  responseName = null;
                                });
                              }
                            },
                          ),
                          hintText: 'Thêm bình luận...',
                          fillColor: context.colors.hint.withOpacity(0.2),
                          isCollapsed: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
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
