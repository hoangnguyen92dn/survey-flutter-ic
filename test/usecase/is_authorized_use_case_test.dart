import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/is_authorized_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('IsAuthorizedUseCase', () {
    late MockAuthPersistence mockPersistence;
    late IsAuthorizedUseCase useCase;

    setUp(() {
      mockPersistence = MockAuthPersistence();
      useCase = IsAuthorizedUseCase(mockPersistence);
    });

    test(
        'When calling IsAuthorizedUseCase successfully, it returns the result Success with true',
        () async {
      when(mockPersistence.accessToken).thenAnswer((_) async => 'accessToken');

      final result = await useCase.call();

      expect(result, isA<Success>());
      expect((result as Success).value, true);
    });

    test(
        'When calling IsAuthorizedUseCase successfully, it returns the result Success with false',
        () async {
      when(mockPersistence.accessToken).thenAnswer((_) async => null);

      final result = await useCase.call();

      expect(result, isA<Success>());
      expect((result as Success).value, false);
    });
  });
}
