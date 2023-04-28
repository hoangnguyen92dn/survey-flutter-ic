import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/database/dto/survey_dto.dart';
import 'package:survey_flutter_ic/database/hive_persistence.dart';

abstract class SurveyPersistence {
  Future<List<SurveyDto>> getSurveys();

  Future<void> add(List<SurveyDto> surveys);

  Future<void> clear();
}

@Singleton(as: SurveyPersistence)
class SurveyPersistenceImpl extends SurveyPersistence {
  final Box _surveyBox;
  final String _surveyKey = 'surveyKey';

  SurveyPersistenceImpl(
    @Named(surveyBoxName) this._surveyBox,
  );

  @override
  Future<List<SurveyDto>> getSurveys() {
    return Future.value(
      List<SurveyDto>.from(
        _surveyBox.get(
          _surveyKey,
          defaultValue: [],
        ),
      ),
    );
  }

  @override
  Future<void> add(List<SurveyDto> surveys) async {
    final currentSurveys = _surveyBox.get(
      _surveyKey,
      defaultValue: <SurveyDto>[],
    ) as List<SurveyDto>;
    currentSurveys.addAll(surveys);
    await _surveyBox.put(_surveyKey, currentSurveys);
  }

  @override
  Future<void> clear() async {
    await _surveyBox.delete(_surveyKey);
  }
}
