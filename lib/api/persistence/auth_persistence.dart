import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _keyTokenType = "KEY_TOKEN_TYPE";
const _keyAccessToken = "KEY_ACCESS_TOKEN";
const _keyRefreshToken = "KEY_REFRESH_TOKEN";

abstract class AuthPersistence {
  Future<String?> get tokenType;

  Future<String?> get accessToken;

  Future<String?> get refreshToken;

  Future<void> storeTokenType(String tokenType);

  Future<void> storeAccessToken(String accessToken);

  Future<void> storeRefreshToken(String refreshToken);

  Future<void> clearAllStorage();
}

@Singleton(as: AuthPersistence)
class AuthPersistenceImpl extends AuthPersistence {
  final FlutterSecureStorage _storage;

  AuthPersistenceImpl(this._storage);

  @override
  Future<String?> get tokenType => _storage.read(key: _keyTokenType);

  @override
  Future<String?> get accessToken => _storage.read(key: _keyAccessToken);

  @override
  Future<String?> get refreshToken => _storage.read(key: _keyRefreshToken);

  @override
  Future<void> storeTokenType(String tokenType) {
    return _storage.write(key: _keyTokenType, value: tokenType);
  }

  @override
  Future<void> storeAccessToken(String accessToken) {
    return _storage.write(key: _keyAccessToken, value: accessToken);
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) {
    return _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  @override
  Future<void> clearAllStorage() {
    return _storage.deleteAll();
  }
}
