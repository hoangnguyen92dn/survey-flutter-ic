import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/profile_service.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';

import '../exception/network_exceptions.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
}

@Singleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileService _profileService;

  ProfileRepositoryImpl(this._profileService);

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await _profileService.getProfile();
      return ProfileModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
