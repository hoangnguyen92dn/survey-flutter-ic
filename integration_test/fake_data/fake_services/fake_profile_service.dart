import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';

import '../fake_data.dart';

class FakeAuthService extends Fake implements AuthService {
  @override
  Future<ProfileResponse> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 5));
    final response = FakeData.apiAndResponse[keyUserProfile]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return ProfileResponse.fromJson(response.json);
  }
}