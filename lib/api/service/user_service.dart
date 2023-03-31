import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';

part 'user_service.g.dart';

abstract class UserService {
  Future<ProfileResponse> getProfile();
}

@RestApi()
abstract class UserServiceImpl extends UserService {
  factory UserServiceImpl(Dio dio, {String baseUrl}) = _UserServiceImpl;

  @override
  @GET('/api/v1/me')
  Future<ProfileResponse> getProfile();
}
