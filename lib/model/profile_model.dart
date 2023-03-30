import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/api/response/profile_response.dart';

class ProfileModel extends Equatable {
  final String avatarUrl;

  const ProfileModel({
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        avatarUrl,
      ];

  factory ProfileModel.fromResponse(ProfileResponse response) {
    return ProfileModel(
      avatarUrl: response.avatarUrl,
    );
  }
}
