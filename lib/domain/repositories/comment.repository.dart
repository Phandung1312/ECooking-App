
import 'package:pair/pair.dart';

import '../entities/comment.dart';
import '../entities/params/paginate_comment_params.dart';

abstract class CommentRepository{
  Future<Pair<int, List<Comment>>> getComments(PaginateCommentParams commentParams);
}