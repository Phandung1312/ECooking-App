

import 'package:injectable/injectable.dart';

import '../../core/bases/usecases/base_use_case.dart';
import '../repositories/auth.repository.dart';

@injectable
class LogoutUseCase extends UseCase<void, NoParams?> {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  Future<void> call([NoParams? params]) {
    return _authRepository.logout();
  }


}