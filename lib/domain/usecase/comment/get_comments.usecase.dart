


import 'package:injectable/injectable.dart';
import 'package:pair/pair.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/comment.dart';
import 'package:uq_system_app/domain/entities/params/paginate_comment_params.dart';

import '../../repositories/comment.repository.dart';

@injectable
class GetCommentsUseCase extends UseCase<Pair<int, List<Comment>>, PaginateCommentParams>{
  final CommentRepository _commentRepository;
  GetCommentsUseCase(this._commentRepository);

  @override
  Future<Pair<int, List<Comment>>> call(PaginateCommentParams params) {
    return _commentRepository.getComments(params);
  }


}