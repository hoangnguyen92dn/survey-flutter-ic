import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/database/dto/survey_dto.dart';
import 'package:survey_flutter_ic/database/persistence/survey_persistence.dart';

class FakeSurveyPersistence extends Fake implements SurveyPersistence {
  @override
  Future<List<SurveyDto>> getSurveys() async {
    return List.empty();
  }

  @override
  Future<void> add(List<SurveyDto> surveys) async {
    return Future.value();
  }

  @override
  Future<void> clear() async {
    return Future.value();
  }
}
