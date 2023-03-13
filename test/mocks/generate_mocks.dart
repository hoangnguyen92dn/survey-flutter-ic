import 'package:dio/dio.dart';
import 'package:survey_flutter_ic/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';

@GenerateMocks([
  ApiService,
  AuthService,
  AuthRepository,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
