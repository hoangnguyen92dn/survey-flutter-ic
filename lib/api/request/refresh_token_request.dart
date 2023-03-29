import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  final String grantType;
  final String refreshToken;
  final String clientId;
  final String clientSecret;

  RefreshTokenRequest({
    required this.grantType,
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
