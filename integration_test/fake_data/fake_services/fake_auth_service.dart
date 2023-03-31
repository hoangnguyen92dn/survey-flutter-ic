import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:survey_flutter_ic/api/request/sign_in_request.dart';
import 'package:survey_flutter_ic/api/response/auth_response.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';

import '../fake_data.dart';

class FakeAuthService extends Fake implements AuthService {
  @override
  Future<AuthResponse> signIn(
    @Body() SignInRequest body,
  ) async {
    await Future.delayed(const Duration(seconds: 5));
    final response = FakeData.apiAndResponse[keySignIn]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return AuthResponse.fromJson(response.json);
  }
}
