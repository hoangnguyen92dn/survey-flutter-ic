import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

class GetSurveysInput {
  final int pageNumber;
  final int pageSize;

  GetSurveysInput({
    required this.pageNumber,
    required this.pageSize,
  });
}

@Injectable()
class GetSurveysUseCase extends UseCase<List<SurveyModel>, GetSurveysInput> {
  final SurveyRepository _repository;

  const GetSurveysUseCase(this._repository);

  @override
  Future<Result<List<SurveyModel>>> call(GetSurveysInput params) {
    return _repository
        .getSurveys(
          number: params.pageNumber,
          size: params.pageSize,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<List<SurveyModel>>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
