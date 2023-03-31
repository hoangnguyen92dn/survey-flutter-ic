import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/refresh_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCase', () {
    late MockAuthRepository mockRepository;
    late MockAuthPersistence mockPersistence;
    late RefreshTokenUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      mockPersistence = MockAuthPersistence();
      useCase = RefreshTokenUseCase(mockRepository, mockPersistence);
    });

    test(
        'When calling RefreshToken successfully, it returns the result Success',
        () async {
      const authModel = AuthModel(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        refreshToken: 'refreshToken',
      );

      when(mockPersistence.refreshToken)
          .thenAnswer((_) async => 'refreshToken');
      when(mockRepository.refreshToken(refreshToken: 'refreshToken'))
          .thenAnswer((_) async => authModel);

      when(mockPersistence.storeAccessToken(any)).thenAnswer((_) async => {});

      when(mockPersistence.storeRefreshToken(any)).thenAnswer((_) async => {});

      when(mockPersistence.storeTokenType(any)).thenAnswer((_) async => {});

      final result = await useCase.call();

      expect(result, isA<Success>());
    });

    test('When calling RefreshToken failed, it returns the result Failed',
        () async {
      const exception = NetworkExceptions.unexpectedError();

      when(mockPersistence.refreshToken)
          .thenAnswer((_) async => 'refreshToken');
      when(mockRepository.refreshToken(refreshToken: 'refreshToken'))
          .thenAnswer((_) => Future.error(exception));

      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });

    test('When store token failed, it returns the result Failed', () async {
      const authModel = AuthModel(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        refreshToken: 'refreshToken',
      );

      when(mockPersistence.refreshToken)
          .thenAnswer((_) async => 'refreshToken');
      when(mockRepository.refreshToken(refreshToken: 'refreshToken'))
          .thenAnswer((_) async => authModel);

      when(mockPersistence.storeAccessToken(any))
          .thenThrow(PlatformException(code: 'code'));

      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          isA<PlatformException>());
    });
  });
}
