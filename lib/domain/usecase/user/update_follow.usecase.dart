


import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/follow.params.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/user.repository.dart';

@injectable
class UpdateFollowUseCase extends UseCase<void, FollowParams>{
  final UserRepository _userRepository;
  const UpdateFollowUseCase(this._userRepository);
  @override
  Future<void> call(FollowParams params) {
    return _userRepository.updateFollow(params);
  }

}