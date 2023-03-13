import '../../env.dart';
import '../../model/auth_model.dart';
import '../exception/network_exceptions.dart';
import '../request/login_request.dart';
import '../service/auth_service.dart';

const _passwordType = 'password';

abstract class AuthRepository {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.login(
        LoginRequest(
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
}
