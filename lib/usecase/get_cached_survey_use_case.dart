import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/database/persistence/survey_persistence.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';

@Injectable()
class GetCachedSurveysUseCase extends NoParamsUseCase<List<SurveyModel>> {
  final SurveyPersistence _persistence;

  const GetCachedSurveysUseCase(this._persistence);

  @override
  Future<Result<List<SurveyModel>>> call() {
    return _persistence
        .getSurveys()
        .then((value) => value.map((e) => e.toModel()).toList())
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<List<SurveyModel>>)
        .onError<NetworkExceptions>(
            (exception, stackTrace) => Failed(UseCaseException(exception)));
  }
}
