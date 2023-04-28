import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/response/auth_response.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';

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
        'When calling signIn successfully, it emits the corresponding AuthModel',
        () async {
      final response = AuthResponse(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 0,
        refreshToken: 'refreshToken',
        createdAt: 0,
      );

      when(mockAuthService.signIn(any)).thenAnswer((_) async => response);

      final result = await repository.signIn(
        email: 'email',
        password: 'password',
      );

      expect(result, AuthModel.fromResponse(response));
    });

    test('When calling signIn failed, it returns NetworkExceptions error',
        () async {
      when(mockAuthService.signIn(any)).thenThrow(MockDioError());

      result() => repository.signIn(email: 'email', password: 'password');

      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test(
        'When calling refreshToken successfully, it emits the corresponding response',
        () async {
      final response = AuthResponse(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 0,
        refreshToken: 'refreshToken',
        createdAt: 0,
      );

      when(mockAuthService.refreshToken(any)).thenAnswer((_) async => response);

      final result = await repository.refreshToken(
        refreshToken: 'refreshToken',
      );

      expect(result, AuthModel.fromResponse(response));
    });

    test('When calling refreshToken failed, it returns NetworkExceptions error',
        () async {
      when(mockAuthService.refreshToken(any)).thenThrow(MockDioError());

      result() => repository.refreshToken(refreshToken: 'refreshToken');

      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test(
        'When calling signOut successfully, it emits the corresponding response',
        () async {
      when(mockAuthService.signOut(any))
          .thenAnswer((_) async => Future(() => null));

      final result = await repository.signOut(
        token: 'token',
      );

      expect(() async => result, isA<void>());
    });

    test('When calling signOut failed, it returns NetworkExceptions error',
        () async {
      when(mockAuthService.signOut(any)).thenThrow(MockDioError());

      result() => repository.signOut(token: 'token');

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
