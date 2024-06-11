
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/member_details.dart';

import '../../repositories/user.repository.dart';

@injectable
class GetMemberUseCase extends UseCase<MemberDetails, int>{
  final UserRepository _userRepository;
  const GetMemberUseCase(this._userRepository);
  @override
  Future<MemberDetails> call(int params) {
    return _userRepository.getMemberDetails(params);
  }

}