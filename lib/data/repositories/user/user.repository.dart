import 'package:uq_system_app/core/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String userId);
}
