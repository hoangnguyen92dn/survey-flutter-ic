import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/request/sign_out_request.dart';

import '../../env.dart';
import '../../model/auth_model.dart';
import '../exception/network_exceptions.dart';
import '../request/refresh_token_request.dart';
import '../request/sign_in_request.dart';
import '../service/auth_service.dart';

const _passwordType = 'password';
const _refreshTokenType = 'refresh_token';

abstract class AuthRepository {
  Future<AuthModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthModel> refreshToken({
    required String refreshToken,
  });

  Future<void> signOut({
    required String token,
  });
}

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.signIn(
        SignInRequest(
          grantType: _passwordType,
          email: email,
          password: password,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
        ),
      );
      return AuthModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<AuthModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await _authService.refreshToken(
        RefreshTokenRequest(
          grantType: _refreshTokenType,
          refreshToken: refreshToken,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
        ),
      );
      return AuthModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<void> signOut({required String token}) async {
    try {
      final response = await _authService.signOut(
        SignOutRequest(
          token: token,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
        ),
      );
      return response;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
