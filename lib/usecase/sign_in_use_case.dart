import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/persistence/auth_persistence.dart';
import 'package:survey_flutter_ic/model/auth_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

import '../api/repository/auth_repository.dart';

class SignInInput {
  final String email;
  final String password;

  SignInInput({
    required this.email,
    required this.password,
  });
}

@Injectable()
class SignInUseCase extends UseCase<void, SignInInput> {
  final AuthRepository _repository;
  final AuthPersistence _persistence;

  const SignInUseCase(this._repository, this._persistence);

  @override
  Future<Result<void>> call(SignInInput params) {
    return _repository
        .signIn(email: params.email, password: params.password)
        .then((token) => _storeTokens(token))
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }

  Future<Result<void>> _storeTokens(AuthModel authModel) async {
    try {
      await _persistence.storeTokenType(authModel.tokenType);
      await _persistence.storeAccessToken(authModel.accessToken);
      await _persistence.storeRefreshToken(authModel.refreshToken);
      return Success(null);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
