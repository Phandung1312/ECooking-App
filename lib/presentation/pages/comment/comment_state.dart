import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

import '../../../domain/entities/comment.dart';

part 'comment_state.freezed.dart';

enum CommentStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @Default(<Comment>[]) List<Comment> comments,
    @Default(0) int totalComments,
    @Default(0) int page,
    @Default(CommentStatus.initial) CommentStatus status,
    BaseException? error,
  }) = _CommentState;
}
