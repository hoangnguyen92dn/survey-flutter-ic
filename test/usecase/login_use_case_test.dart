import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/login_use_case.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCase', () {
    late MockAuthRepository mockRepository;
    late LoginUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = LoginUseCase(mockRepository);
    });

    test('When calling login successfully, it returns the result Success',
        () async {
      const authModel = AuthModel(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        refreshToken: 'refreshToken',
      );

      when(mockRepository.login(
        email: 'email',
        password: 'password',
      )).thenAnswer((_) async => authModel);

      final result = await useCase.call(
        LoginInput(
          email: 'email',
          password: 'password',
        ),
      );

      expect(result, isA<Success>());
    });

    test('When calling login failed, it returns the result Failed', () async {
      const exception = NetworkExceptions.unexpectedError();

      when(mockRepository.login(
        email: 'email',
        password: 'password',
      )).thenAnswer((_) => Future.error(exception));

      final result = await useCase.call(
        LoginInput(
          email: 'email',
          password: 'password',
        ),
      );

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
