import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';

class ProfileModel extends Equatable {
  final String id;
  final String email;
  final String avatarUrl;

  const ProfileModel({
    required this.id,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        avatarUrl,
      ];

  factory ProfileModel.fromResponse(ProfileResponse response) {
    return ProfileModel(
      id: response.id,
      email: response.email,
      avatarUrl: response.avatarUrl,
    );
  }
}
