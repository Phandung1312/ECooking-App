
import 'package:uq_system_app/domain/entities/enum/enum.dart';

abstract class AuthRepository{
  Future<void> login(LoginType loginType);
  Future<void> logout();
}