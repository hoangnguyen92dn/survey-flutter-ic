import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';

part 'profile_service.g.dart';

abstract class ProfileService {
  Future<ProfileResponse> getProfile();
}

@RestApi()
abstract class ProfileServiceImpl extends ProfileService {
  factory ProfileServiceImpl(Dio dio, {String baseUrl}) = _ProfileServiceImpl;

  @override
  @GET('/api/v1/me')
  Future<ProfileResponse> getProfile();
}
