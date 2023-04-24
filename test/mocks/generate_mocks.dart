import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/api_service.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';
import 'package:survey_flutter_ic/api/service/survey_service.dart';
import 'package:survey_flutter_ic/api/service/user_service.dart';
import 'package:survey_flutter_ic/usecase/get_profile_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_survey_use_case.dart';
import 'package:survey_flutter_ic/usecase/sign_in_use_case.dart';
import 'package:survey_flutter_ic/usecase/submit_survey_use_case.dart';

@GenerateMocks([
  ApiService,
  AuthService,
  UserService,
  SurveyService,
  AuthPersistence,
  AuthRepository,
  UserRepository,
  SurveyRepository,
  SignInUseCase,
  GetSurveysUseCase,
  GetProfileUseCase,
  GetSurveyDetailsUseCase,
  SubmitSurveyUseCase,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
