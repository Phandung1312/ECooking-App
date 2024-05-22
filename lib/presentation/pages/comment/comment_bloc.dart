import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_event.dart';
import 'package:uq_system_app/presentation/pages/comment/comment_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/params/paginate_comment_params.dart';
import '../../../domain/usecase/comment/get_comments.usecase.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  CommentBloc(this.getCommentsUseCase) : super(const CommentState()) {
    on<CommentErrorOccurred>(_onErrorOccurred);
    on<CommentLoad>(_onLoad);
  }

  FutureOr<void> _onLoad(
      CommentLoad event, Emitter<CommentState> emit) async {
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
      comments: event.isLoadMore?  [...state.comments, ...comments.value] : comments.value,
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
    emit(state.copyWith(
      status: CommentStatus.failure,
    ));
  }
}
