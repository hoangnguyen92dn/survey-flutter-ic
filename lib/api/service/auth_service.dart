import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../request/sign_in_request.dart';
import '../response/auth_response.dart';

part 'auth_service.g.dart';

abstract class AuthService {
  Future<AuthResponse> signIn(
    @Body() SignInRequest body,
  );
}

@RestApi()
abstract class AuthServiceImpl extends AuthService {
  factory AuthServiceImpl(Dio dio, {String baseUrl}) = _AuthServiceImpl;

  @override
  @POST('/api/v1/oauth/token')
  Future<AuthResponse> signIn(
    @Body() SignInRequest body,
  );
}
