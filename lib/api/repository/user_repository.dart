import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/user_service.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';

import '../exception/network_exceptions.dart';

abstract class UserRepository {
  Future<ProfileModel> getProfile();
}

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await _userService.getProfile();
      return ProfileModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
