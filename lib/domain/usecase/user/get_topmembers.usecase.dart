


import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/member.dart';
import '../../repositories/user.repository.dart';

@injectable
class GetTopMembersUseCase extends UseCase<List<Member>, CommonPaginateParams> {
  final UserRepository _userRepository;

  GetTopMembersUseCase(this._userRepository);

  @override
  Future<List<Member>> call(CommonPaginateParams params) async {
    return await _userRepository.getTopMembers(params);
  }
}