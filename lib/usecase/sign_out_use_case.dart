import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/database/persistence/survey_persistence.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../api/repository/auth_repository.dart';

@Injectable()
class SignOutUseCase extends NoParamsUseCase<void> {
  final AuthRepository _repository;
  final AuthPersistence _authPersistence;
  final SurveyPersistence _surveyPersistence;

  const SignOutUseCase(
    this._repository,
    this._authPersistence,
    this._surveyPersistence,
  );

  @override
  Future<Result<void>> call() async {
    final token = await _authPersistence.accessToken ?? '';
    return _repository
        .signOut(token: token)
        // ignore: unnecessary_cast
        .then((_) => clearPersistence())
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }

  Future<Result<void>> clearPersistence() async {
    try {
      await _surveyPersistence.clear();
      await _authPersistence.clearAllStorage();
      return Success(null);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
