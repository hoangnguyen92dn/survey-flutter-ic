import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/database/hive_persistence.dart';

@module
abstract class DatabaseModule {

  @Named(surveyBoxName)
  @singleton
  @preResolve
  Future<Box> get surveyBox => Hive.openBox(surveyBoxName);
}