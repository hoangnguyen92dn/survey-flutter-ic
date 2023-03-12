import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';
import 'package:survey_flutter_ic/di/provider/dio_provider.dart';
import '../../env.dart';

@module
abstract class ServiceModule {
  @Singleton(as: AuthService)
  AuthServiceImpl provideAuthService(DioProvider dioProvider) {
    return AuthServiceImpl(
      dioProvider.getDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
