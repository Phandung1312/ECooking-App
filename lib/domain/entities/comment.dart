

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/account.dart';
part 'comment.freezed.dart';
@freezed
class Comment with _$Comment{
  const factory Comment({
    @Default(0) int id,
    @Default('') String content,
    @Default('') String createdAt,
    @Default(Account()) Account author,
    @Default([]) List<Comment> subComments,
    @Default(false) bool isSending,
  }) = _Comment;
}