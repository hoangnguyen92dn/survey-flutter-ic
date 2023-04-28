import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/sign_out_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SignOutUseCase', () {
    late MockAuthRepository mockRepository;
    late MockAuthPersistence mockPersistence;
    late SignOutUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      mockPersistence = MockAuthPersistence();
      useCase = SignOutUseCase(mockRepository, mockPersistence);
    });

    test('When calling signOut successfully, it returns the result Success',
        () async {
      when(mockRepository.signOut(
        token: 'accessToken',
      )).thenAnswer((_) async => Future(() => null));

      when(mockPersistence.accessToken).thenAnswer((_) async => 'accessToken');

      final result = await useCase.call();

      verify(mockPersistence.clearAllStorage()).called(1);
      expect(result, isA<Success>());
    });

    test('When calling signOut failed, it returns the result Failed', () async {
      const exception = NetworkExceptions.unexpectedError();

      when(mockRepository.signOut(
        token: 'accessToken',
      )).thenAnswer((_) => Future.error(exception));

      when(mockPersistence.accessToken).thenAnswer((_) async => 'accessToken');

      final result = await useCase.call();

      verifyNever(mockPersistence.clearAllStorage());
      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
