import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/api/response/converter/response_converter.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  final String id;
  final String type;
  final String email;
  final String avatarUrl;

  ProfileResponse({
    required this.id,
    required this.type,
    required this.email,
    required this.avatarUrl,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(fromDataJsonApi(json));
}
