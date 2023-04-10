import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/profile_model.dart';

class ProfileUiModel extends Equatable {
  final String id;
  final String email;
  final String avatarUrl;

  const ProfileUiModel({
    required this.id,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        avatarUrl,
      ];

  factory ProfileUiModel.fromModel(ProfileModel model) {
    return ProfileUiModel(
      id: model.id,
      email: model.email,
      avatarUrl: model.avatarUrl,
    );
  }
}
