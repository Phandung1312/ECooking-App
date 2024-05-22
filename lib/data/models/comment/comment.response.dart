

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/domain/entities/comment.dart';
part 'comment.response.freezed.dart';
part 'comment.response.g.dart';
@freezed
class CommentResponse with _$CommentResponse {
  const CommentResponse._();
  const factory CommentResponse({
    required int id,
    required String content,
    required String createdAt,
    required AccountResponse author,
    List<CommentResponse>? subComments,
  }) = _CommentResponse;

  factory CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);
  Comment mapToEntity(){
    return Comment(
      id: id,
      content: content,
      createdAt: createdAt,
      author: author.mapToEntity(),
      subComments: subComments?.map((e) => e.mapToEntity()).toList() ?? [],
    );
  }
}