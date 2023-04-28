import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/sign_out_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SignOutUseCase', () {
    late MockAuthRepository mockRepository;
    late MockAuthPersistence mockAuthPersistence;
    late MockSurveyPersistence mockSurveyPersistence;
    late SignOutUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      mockAuthPersistence = MockAuthPersistence();
      mockSurveyPersistence = MockSurveyPersistence();

      useCase = SignOutUseCase(
        mockRepository,
        mockAuthPersistence,
        mockSurveyPersistence,
      );
    });

    test('When calling signOut successfully, it returns the result Success',
        () async {
      when(mockRepository.signOut(
        token: 'accessToken',
      )).thenAnswer((_) async => Future(() => null));

      when(mockAuthPersistence.accessToken)
          .thenAnswer((_) async => 'accessToken');

      final result = await useCase.call();

      verify(mockAuthPersistence.clearAllStorage()).called(1);
      verify(mockSurveyPersistence.clear()).called(1);
      expect(result, isA<Success>());
    });

    test('When calling signOut failed, it returns the result Failed', () async {
      const exception = NetworkExceptions.unexpectedError();

      when(mockRepository.signOut(
        token: 'accessToken',
      )).thenAnswer((_) => Future.error(exception));

      when(mockAuthPersistence.accessToken)
          .thenAnswer((_) async => 'accessToken');

      final result = await useCase.call();

      verifyNever(mockAuthPersistence.clearAllStorage());
      verifyNever(mockSurveyPersistence.clear());
      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
