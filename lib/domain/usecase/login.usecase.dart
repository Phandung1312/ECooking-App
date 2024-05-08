
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/repositories/auth.repository.dart';

@lazySingleton
class LoginUseCase extends UseCase<void, LoginType>{
  final AuthRepository _authRepository;

  const LoginUseCase(this._authRepository);

  @override
  Future<void> call(LoginType params) {
    return _authRepository.login(params);
  }

}