import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class RefreshTokenUseCase extends NoParamsUseCase<AuthModel> {
  final AuthRepository _repository;
  final AuthPersistence _persistence;

  const RefreshTokenUseCase(this._repository, this._persistence);

  @override
  Future<Result<AuthModel>> call() async {
    final refreshToken = await _persistence.refreshToken ?? '';

    return _repository
        .refreshToken(refreshToken: refreshToken)
        .then((value) => _storeTokens(value))
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }

  Future<Result<AuthModel>> _storeTokens(AuthModel authModel) async {
    try {
      await _persistence.storeTokenType(authModel.tokenType);
      await _persistence.storeAccessToken(authModel.accessToken);
      await _persistence.storeRefreshToken(authModel.refreshToken);
      return Success(authModel);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
