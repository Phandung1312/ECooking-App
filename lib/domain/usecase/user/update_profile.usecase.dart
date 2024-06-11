

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/data/models/account/account.request.dart';
import 'package:uq_system_app/domain/repositories/user.repository.dart';

@injectable
class UpdateProfileUseCase extends UseCase<void, AccountRequest>{
  final UserRepository _userRepository;
  const UpdateProfileUseCase(this._userRepository);
  @override
  Future<void> call(AccountRequest params) {
    return _userRepository.updateProfile(params);
  }

}