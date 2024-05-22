
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:uq_system_app/data/sources/local/local.dart';

import '../domain/entities/account.dart';

@lazySingleton
class UserInfoHelper {
  final AuthServices _authServices;
  final LocalDataSource _localDataSource;
  const UserInfoHelper(this._authServices, this._localDataSource);
   Future<bool> isUserLogged() async{
    var accessToken = await _authServices.getAccessToken();
    return accessToken != null;
  }
  Future<Account?> getAccountUser() async{
    return  _localDataSource.getAccount();
  }
}