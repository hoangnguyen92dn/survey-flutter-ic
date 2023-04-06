import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/get_profile_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetProfileUseCase', () {
    late MockUserRepository mockRepository;
    late GetProfileUseCase useCase;

    setUp(() {
      mockRepository = MockUserRepository();
      useCase = GetProfileUseCase(mockRepository);
    });

    test('When calling getProfile successfully, it returns the result Success',
        () async {
      const profileModel = ProfileModel(
        id: 'id',
        email: 'email',
        avatarUrl: 'avatarUrl',
      );

      when(mockRepository.getProfile()).thenAnswer((_) async => profileModel);

      final result = await useCase.call();

      expect(result, isA<Success>());
    });

    test('When calling getProfile failed, it returns the result Failed',
        () async {
      const exception = NetworkExceptions.unexpectedError();

      when(mockRepository.getProfile())
          .thenAnswer((_) => Future.error(exception));

      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
