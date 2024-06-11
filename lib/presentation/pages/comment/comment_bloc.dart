import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/usecase/comment/create_comment.usecase.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_event.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/entities/params/paginate_comment_params.dart';
import '../../../domain/usecase/comment/get_comments.usecase.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  late RefreshController refreshController =
      RefreshController(initialRefresh: true);

  CommentBloc(this.getCommentsUseCase, this.createCommentUseCase)
      : super(const CommentState()) {
    on<CommentErrorOccurred>(_onErrorOccurred);
    on<CommentLoad>(_onLoad);
    on<CommentCreateComment>(_onCreateComment);
  }

  FutureOr<void> _onCreateComment(
      CommentCreateComment event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.sending));
    if (event.commentRequest.parentId != null) {
      var currentComments = List<Comment>.from(state.comments);
      var index = currentComments
          .indexWhere((element) => element.id == event.commentRequest.parentId);
      if (index != -1) {
        var subComments = List<Comment>.from(currentComments[index].subComments);
        subComments.add(Comment(
          content: event.commentRequest.content ?? "",
          author: event.userInfo,
          isSending: true,
        ));
        currentComments[index] = currentComments[index].copyWith(
          subComments: subComments,
        );
        emit(state.copyWith(comments: currentComments));
      }
    }
    else{
      emit(state.copyWith(
        comments: [
          ...state.comments, Comment(
            author: event.userInfo,
            isSending: true,
            content: event.commentRequest.content ?? "",)]));
    }
    final result = await createCommentUseCase(event.commentRequest);
    if(event.commentRequest.parentId != null) {
      var currentComments = List<Comment>.from(state.comments);
      var index = currentComments.indexWhere((element) => element.id == event.commentRequest.parentId);
      if (index != -1) {
        var subComments = List<Comment>.from(currentComments[index].subComments);
        subComments.removeWhere((element) => element.isSending);
        subComments.add(result);
        currentComments[index] = currentComments[index].copyWith(
          subComments: subComments,
        );
        emit(state.copyWith(comments: currentComments, status: CommentStatus.success));
      }
    } else {
      var currentComments = List<Comment>.from(state.comments);
      currentComments.removeWhere((element) => element.isSending);
      emit(
        state.copyWith(
          comments: [result, ...currentComments],
          totalComments: state.totalComments + 1,
          status: CommentStatus.success,
        )
      );
    }
  }

  FutureOr<void> _onLoad(CommentLoad event, Emitter<CommentState> emit) async {
    emit(state.copyWith(
      status:
          !event.isLoadMore ? CommentStatus.loading : CommentStatus.loadingMore,
      page: event.isLoadMore ? state.page : 1,
    ));
    final comments = await getCommentsUseCase(PaginateCommentParams(
        recipeId: event.recipeId, page: state.page, perPage: 20));
    if (event.isLoadMore) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
    emit(state.copyWith(
      comments: event.isLoadMore
          ? [...state.comments, ...comments.value]
          : comments.value,
      totalComments: comments.key,
      page: state.page + 1,
      status: CommentStatus.success,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (refreshController.isLoading) refreshController.loadComplete();
    if (refreshController.isRefresh) refreshController.refreshCompleted();
    add(CommentErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    CommentErrorOccurred event,
    Emitter<CommentState> emit,
  ) {
    if(state.status == CommentStatus.sending){
      var currentComments = List<Comment>.from(state.comments);
      currentComments.removeWhere((element) => element.isSending);
      emit(state.copyWith(
        comments: currentComments,
        status: CommentStatus.failure,
      ));
    }
    else {
      emit(state.copyWith(
      status: CommentStatus.failure,
    ));
    }
  }
}
