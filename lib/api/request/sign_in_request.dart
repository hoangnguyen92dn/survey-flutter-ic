import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable()
class SignInRequest {
  final String grantType;
  final String email;
  final String password;
  final String clientId;
  final String clientSecret;

  SignInRequest({
    required this.grantType,
    required this.email,
    required this.password,
    required this.clientId,
    required this.clientSecret,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
