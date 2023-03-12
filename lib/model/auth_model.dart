import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/auth_response.dart';

class AuthModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final String refreshToken;

  const AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        refreshToken,
      ];

  factory AuthModel.fromResponse(AuthResponse response) {
    return AuthModel(
      accessToken: response.accessToken,
      tokenType: response.tokenType,
      refreshToken: response.refreshToken,
    );
  }
}
