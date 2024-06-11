
import 'package:freezed_annotation/freezed_annotation.dart';
part 'comment.request.freezed.dart';
part 'comment.request.g.dart';
@freezed
class CommentRequest with _$CommentRequest {
  const factory CommentRequest({
   String? content,
    int? parentId,
    int? recipeId,
    int? responseId
  }) = _CommentRequest;

  factory CommentRequest.fromJson(Map<String, dynamic> json) => _$CommentRequestFromJson(json);
}