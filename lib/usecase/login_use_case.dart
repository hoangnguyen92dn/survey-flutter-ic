import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import '../api/exception/network_exceptions.dart';
import '../api/repository/auth_repository.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends UseCase<void, LoginInput> {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<void>> call(LoginInput params) {
    return _repository
        .login(email: params.email, password: params.password)
        // ignore: unnecessary_cast
        .then((value) => Success(null) as Result<void>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
