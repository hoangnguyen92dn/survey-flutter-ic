import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class GetProfileUseCase extends NoParamsUseCase<ProfileModel> {
  final UserRepository _repository;

  const GetProfileUseCase(this._repository);

  @override
  Future<Result<ProfileModel>> call() {
    return _repository
        .getProfile()
        // ignore: unnecessary_cast
        .then((profile) => Success(profile) as Result<ProfileModel>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
