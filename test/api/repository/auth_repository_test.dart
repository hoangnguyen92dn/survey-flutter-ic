import 'package:flutter_config/flutter_config.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/response/auth_response.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'CLIENT_ID': 'CLIENT_ID',
    'CLIENT_SECRET': 'CLIENT_SECRET',
  });

  group('AuthRepository', () {
    late MockAuthService mockAuthService;
    late AuthRepository repository;

    setUp(() {
      mockAuthService = MockAuthService();
      repository = AuthRepositoryImpl(mockAuthService);
    });

    test(
        'When calling login successfully, it emits the corresponding AuthModel',
        () async {
      final response = AuthResponse(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 0,
        refreshToken: 'refreshToken',
        createdAt: 0,
      );

      when(mockAuthService.login(any)).thenAnswer((_) async => response);

      final result = await repository.login(
        email: 'email',
        password: 'password',
      );

      expect(result, AuthModel.fromResponse(response));
    });

    test('When calling login failed, it returns NetworkExceptions error',
        () async {
      when(mockAuthService.login(any)).thenThrow(MockDioError());

      result() => repository.login(email: 'email', password: 'password');

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
