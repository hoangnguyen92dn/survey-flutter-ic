import 'package:dio/dio.dart';
import 'package:survey_flutter_ic/model/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // TODO add API endpoint
  @GET('users')
  Future<List<UserResponse>> getUsers();
}
