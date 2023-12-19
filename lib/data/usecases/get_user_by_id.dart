import 'package:uq_system_app/core/entities/user.dart';
import 'package:uq_system_app/data/repositories/user/user.repository.dart';

class GetUserById {
  final UserRepository userRepository;

  GetUserById(this.userRepository);

  Future<User> call(String userId) async {
    return await userRepository.getUserById(userId);
  }
}
