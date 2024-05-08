import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';

@lazySingleton
class Logout extends UseCase<void, NoParams?> {
  final AuthServices _authRepository;

  const Logout(this._authRepository);

  @override
  Future<void> call([NoParams? params]) {
    return _authRepository.logout();
  }
}
