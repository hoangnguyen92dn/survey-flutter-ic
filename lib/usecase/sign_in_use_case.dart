import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import '../api/exception/network_exceptions.dart';
import '../api/repository/auth_repository.dart';

class SignInInput {
  final String email;
  final String password;

  SignInInput({
    required this.email,
    required this.password,
  });
}

class SignInUseCase extends UseCase<void, SignInInput> {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  @override
  Future<Result<void>> call(SignInInput params) {
    return _repository
        .signIn(email: params.email, password: params.password)
        // ignore: unnecessary_cast
        .then((value) => Success(null) as Result<void>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
