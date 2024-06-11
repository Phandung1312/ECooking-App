



import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../../data/models/comment/comment.request.dart';
import '../../entities/comment.dart';
import '../../repositories/comment.repository.dart';

@injectable
class CreateCommentUseCase extends UseCase<Comment, CommentRequest> {
  final CommentRepository _commentRepository;

  CreateCommentUseCase(this._commentRepository);

  @override
  Future<Comment> call(CommentRequest params) {
    return _commentRepository.createComment(params);
  }
}