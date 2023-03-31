import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/api_service.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';
import 'package:survey_flutter_ic/usecase/sign_in_use_case.dart';

@GenerateMocks([
  ApiService,
  AuthService,
  AuthRepository,
  AuthPersistence,
  SignInUseCase,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
