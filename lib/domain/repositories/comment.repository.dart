
import 'package:pair/pair.dart';
import 'package:uq_system_app/data/models/comment/comment.request.dart';

import '../entities/comment.dart';
import '../entities/params/paginate_comment_params.dart';

abstract class CommentRepository{
  Future<Pair<int, List<Comment>>> getComments(PaginateCommentParams commentParams);
  //Wrongs dependency
  Future<Comment> createComment(CommentRequest commentRequest);
}