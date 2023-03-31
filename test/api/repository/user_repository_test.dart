import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'CLIENT_ID': 'CLIENT_ID',
    'CLIENT_SECRET': 'CLIENT_SECRET',
  });

  group('UserRepository', () {
    late MockUserService mockUserService;
    late UserRepository repository;

    setUp(() {
      mockUserService = MockUserService();
      repository = UserRepositoryImpl(mockUserService);
    });

    test(
        'When calling getProfile successfully, it emits the corresponding ProfileModel',
        () async {
      final response = ProfileResponse(
        id: 'id',
        type: 'type',
        email: 'email',
        avatarUrl: 'avatarUrl',
      );

      when(mockUserService.getProfile()).thenAnswer((_) async => response);

      final result = await repository.getProfile();

      expect(result, ProfileModel.fromResponse(response));
    });

    test('When calling getProfile failed, it returns NetworkExceptions error',
        () async {
      when(mockUserService.getProfile()).thenThrow(MockDioError());

      result() => repository.getProfile();

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
