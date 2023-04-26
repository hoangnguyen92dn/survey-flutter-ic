import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_out_request.g.dart';

@JsonSerializable()
class SignOutRequest {
  final String token;
  final String clientId;
  final String clientSecret;

  SignOutRequest({
    required this.token,
    required this.clientId,
    required this.clientSecret,
  });

  factory SignOutRequest.fromJson(Map<String, dynamic> json) =>
      _$SignOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutRequestToJson(this);
}
