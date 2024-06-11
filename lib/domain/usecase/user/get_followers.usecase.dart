

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/member.dart';
import '../../entities/params/common_paginate.params.dart';
import '../../repositories/user.repository.dart';

@injectable
class GetFollowersUseCase extends UseCase<List<Member>, CommonPaginateParams> {
  final UserRepository _userRepository;

  GetFollowersUseCase(this._userRepository);

  @override
  Future<List<Member>> call(params) {
    return _userRepository.getFollowers(params);
  }


}