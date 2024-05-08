import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/services/auth/auth.services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@LazySingleton(as : AuthServices)
class AuthServicesImpl extends AuthServices {
  static const String _prefix = '@@oauth-token';

  final String key;
  final FlutterSecureStorage _storage;

  const AuthServicesImpl._(
    this._storage,
    this.key,
  );

  const AuthServicesImpl(FlutterSecureStorage storage,  @Named('key') String? key)
      : this._(storage, key ?? 'default');

  String get _accessTokenKey => '$_prefix/$key/accessToken';

  String get _refreshTokenKey => '$_prefix/$key/refreshToken';

  @override
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey).onError((_, __) => null);
  }

  @override
  Future<Map<String, dynamic>?> getAuthenticatedHeaders(
      Map<String, dynamic> headers) async {
    final accessToken = await getAccessToken();

    if (accessToken == null) {
      return headers;
    }

    return {
      ...headers,
      'token': 'Bearer $accessToken',
    };
  }

  @override
  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshTokenKey).onError((_, __) => null);
  }

  @override
  Future<void> removeAllTokens() async {
    Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  @override
  Future<void> saveAccessToken(String? token) {
    return _storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String? token) {
    return _storage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<void> logout() async {
    await removeAllTokens();
  }
}
