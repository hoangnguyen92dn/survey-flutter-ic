import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/request/submit_survey_request.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class SubmitSurveyUseCase extends UseCase<void, SubmitSurveyRequest> {
  final SurveyRepository _repository;

  const SubmitSurveyUseCase(this._repository);

  @override
  Future<Result<void>> call(SubmitSurveyRequest params) {
    // TODO Create UseCase Input model to pass params
    return _repository
        .submitSurvey(
          request: params,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<void>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
