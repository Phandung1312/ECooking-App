

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/models/login/google_login_params.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/repositories/auth.repository.dart';
import 'package:uq_system_app/helpers/google_auth.helper.dart';

import '../sources/local/local.dart';
import '../sources/network/network.dart';

@LazySingleton(as : AuthRepository)
class AuthRepositoryImpl extends AuthRepository{
  final NetworkDataSource _networkDataSource;
  final LocalDataSource _localDataSource;
  AuthRepositoryImpl(this._networkDataSource, this._localDataSource);
  @override
  Future<void> login(LoginType loginType) async{
    if(loginType == LoginType.google){
      String? idToken = await GoogleAuthHelper.handleSignIn();
      var result = await _networkDataSource.googleLogin(GoogleLoginParams(idToken: idToken ?? ""));
      await _localDataSource.saveAccount(result.data.mapToEntity());
    }
  }


}