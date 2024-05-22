
import 'package:freezed_annotation/freezed_annotation.dart';
part 'paginate_comment_params.freezed.dart';
@freezed
class PaginateCommentParams with _$PaginateCommentParams {
  const factory PaginateCommentParams({
    @Default(0) int recipeId,
    @Default(0) int page,
    @Default(0) int perPage,
  }) = _PaginateCommentParams;
}