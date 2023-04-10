import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_details_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class GetSurveyDetailsUseCase extends UseCase<SurveyDetailsModel, String> {
  final SurveyRepository _repository;

  const GetSurveyDetailsUseCase(this._repository);

  @override
  Future<Result<SurveyDetailsModel>> call(String params) {
    return _repository
        .getSurveyDetails(
          id: params,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<SurveyDetailsModel>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
