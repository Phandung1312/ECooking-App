

import 'package:injectable/injectable.dart';
import 'package:pair/pair.dart';
import 'package:uq_system_app/data/models/comment/comment.request.dart';

import 'package:uq_system_app/domain/entities/comment.dart';
import 'package:uq_system_app/domain/entities/params/paginate_comment_params.dart';
import 'package:uq_system_app/domain/repositories/comment.repository.dart';

import '../sources/network/network.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl extends CommentRepository{
  final NetworkDataSource _networkDataSource;
  CommentRepositoryImpl(this._networkDataSource);
  @override
  Future<Pair<int, List<Comment>>> getComments(PaginateCommentParams commentParams) async{
    var result =  await _networkDataSource.getComments(commentParams.recipeId, commentParams.page, commentParams.perPage);
    return  Pair(result.total, result.data.map((e) => e.mapToEntity()).toList());
  }

  @override
  Future<Comment> createComment(CommentRequest commentRequest) async{
    var result = await _networkDataSource.createComment(commentRequest);
    return result.data.mapToEntity();
  }

}